//
//  set_realtime.cpp
//  sdrplay1
//
// https://chromium.googlesource.com/chromium/src/+/refs/tags/112.0.5597.0/base/threading/platform_thread_mac.mm

#include <mach/mach.h>
#include <mach/mach_time.h>
#include <mach/thread_policy.h>
#include <iostream>


/// Get the conversion factor from milliseconds to Mach absolute time ticks
static double ms_mach_ticks() {
    mach_timebase_info_data_t tb_info;
    mach_timebase_info(&tb_info);
    return (static_cast<double>(tb_info.denom) / tb_info.numer) * 1000000;
}

/// Enable time-contraint policy and priority suitable for low-latency,
/// glitch-resistant audio.
/// - Parameter work_period: The period of intended work cycle in Seconds - the
///                          playout time of the audio buffer
extern "C" int set_realtime(double work_period) {
    mach_port_t mach_thread_id = pthread_mach_thread_np(pthread_self());

    // Increase thread priority to real-time.
    // Please note that the thread_policy_set() calls may fail in
    // rare cases if the kernel decides the system is under heavy load
    // and is unable to handle boosting the thread priority.
    // In these cases we just return early and go on with life.
    // Make thread fixed priority.
    thread_extended_policy_data_t policy;
    policy.timeshare = 0;  // Set to 1 for a non-fixed thread.
    kern_return_t result =
        thread_policy_set(mach_thread_id,
                          THREAD_EXTENDED_POLICY,
                          reinterpret_cast<thread_policy_t>(&policy),
                          THREAD_EXTENDED_POLICY_COUNT);
    if (result != KERN_SUCCESS) {
        // Codes in /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/mach/kern_return.h
        std::cerr << "set_realtime thread_policy_set THREAD_EXTENDED_POLICY " << result << std::endl;
        return 0;
    }
    // Set to relatively high priority.
    thread_precedence_policy_data_t precedence;
    precedence.importance = 63;
    result = thread_policy_set(mach_thread_id,
                               THREAD_PRECEDENCE_POLICY,
                               reinterpret_cast<thread_policy_t>(&precedence),
                               THREAD_PRECEDENCE_POLICY_COUNT);
    if (result != KERN_SUCCESS) {
        std::cerr << "set_realtime thread_policy_set THREAD_PRECEDENCE_POLICY " << result << std::endl;
        return 0;
    }
    // Most important, set real-time constraints.
    // Define the guaranteed and max fraction of time for the audio thread.
    // These "duty cycle" values can range from 0 to 1.  A value of 0.5
    // means the scheduler would give half the time to the thread.
    // These values have empirically been found to yield good behavior.
    // Good means that audio performance is high and other threads won't starve.
    const double kGuaranteedAudioDutyCycle = 0.75;
    const double kMaxAudioDutyCycle = 0.85;
    // Define constants determining how much time the audio thread can
    // use in a given time quantum.  All times are in milliseconds.
    // About 128 frames @44.1KHz
    const double kTimeQuantum = work_period * 1000; // bufferSize / sampleRate; // 128 / 44.1 ~= 2.9;
    //std::cout << "set_realtime kTimeQuantum " << kTimeQuantum << " ms" << std::endl;
    // Time guaranteed each quantum.
    const double kAudioTimeNeeded = kGuaranteedAudioDutyCycle * kTimeQuantum;
    // Maximum time each quantum.
    const double kMaxTimeAllowed = kMaxAudioDutyCycle * kTimeQuantum;
    // Get the conversion factor from milliseconds to absolute time
    // which is what the time-constraints call needs.
    double ms_to_mach_ticks = ms_mach_ticks();
    thread_time_constraint_policy_data_t time_constraints;
    time_constraints.period = kTimeQuantum * ms_to_mach_ticks;
    time_constraints.computation = kAudioTimeNeeded * ms_to_mach_ticks;
    time_constraints.constraint = kMaxTimeAllowed * ms_to_mach_ticks;
    time_constraints.preemptible = 0;
    result =
        thread_policy_set(mach_thread_id,
                         THREAD_TIME_CONSTRAINT_POLICY,
                         reinterpret_cast<thread_policy_t>(&time_constraints),
                         THREAD_TIME_CONSTRAINT_POLICY_COUNT);
    if (result != KERN_SUCCESS) {
        std::cerr << "set_realtime thread_policy_set THREAD_TIME_CONSTRAINT_POLICY " << result << std::endl;
        return 0;
    }
    return 1;
}


#include <AudioToolbox/AudioToolbox.h>
#include <os/workgroup.h>

static bool JoinWorkGroup(AudioDeviceID deviceID) {
    os_workgroup_t workgroup;
    UInt32 propertySize = sizeof(os_workgroup_t);
    
    AudioObjectPropertyAddress propertyAddress = {
        .mSelector= kAudioDevicePropertyIOThreadOSWorkgroup,
        .mScope= kAudioObjectPropertyScopeGlobal,
        .mElement= kAudioObjectPropertyElementMain};
    OSStatus caresult = AudioObjectGetPropertyData(deviceID, &propertyAddress, 0, nullptr,
                                                   &propertySize, &workgroup);
    if (caresult != noErr){
        std::cerr << "set_realtime xxx AudioObjectGetPropertyData " << static_cast<SInt32>(caresult) << std::endl;
        return false;
    }
    std::cout << "set_realtime xxx property size" << propertySize << std::endl;
    
    os_workgroup_join_token_s joinToken;
    const int result = os_workgroup_join(workgroup, &joinToken);
    if (result != 0) {
        std::cerr << "JoinWorkgroup os_workgroup_join " << result << std::endl;
        return false;
    }
    return true;
}

#if 0

//  https://developer.apple.com/documentation/audiotoolbox/workgroup_management/adding_asynchronous_real-time_threads_to_audio_workgroups


os_workgroup_interval_t _Nullable workgroup =
    AudioWorkIntervalCreate("My Work Interval", OS_CLOCK_MACH_ABSOLUTE_TIME, nullptr);

/// Join this thread to the workgroup.
extern "C" bool JoinWorkgroup() {
    os_workgroup_join_token_s joinToken;
    const int result = os_workgroup_join(workgroup, &joinToken);
    if (result != 0) {
        std::cerr << "JoinWorkgroup os_workgroup_join " << result << std::endl;
        return false;
    }
    return true;
}

extern "C" bool LeaveWorkgroup() {
    const int result = os_workgroup_leave(workgroup, &joinToken);
    if (result != 0) {
        std::cerr << "JoinWorkgroup os_workgroup_join " << result << std::endl;
        return false;
    }
    return true;
}

/// Call os_workgroup_interval_start each time the thread begins a work cycle
extern "C" int StartWorkCycle(uint64_t interval_mach_ticks) {
    const auto currentTime = mach_absolute_time();
    const auto deadline = currentTime + interval_mach_ticks;

    const int result = os_workgroup_interval_start(workgroup, currentTime, deadline, nullptr);
    if (result != 0) {
        std::cerr << "StartWorkCycle os_workgroup_interval_start " << result << std::endl;
        return 0;
    }
    return 1;
}

/// Call os_workgroup_interval_finish on completion of each a work cycle.
extern "C" int FinishWorkCycle() {
    const int result = os_workgroup_interval_finish(workgroup, nullptr);
    if (result != 0) {
        std::cerr << "FinishWorkCycle os_workgroup_interval_finish " << result << std::endl;
        return 0;
    }
    return 1;
}

#endif
