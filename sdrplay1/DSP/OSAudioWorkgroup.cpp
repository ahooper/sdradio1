/*
 * https://gist.github.com/cjappl/20fed4c5631099989af9ca900db68bfa
 */

#include <mach/mach_time.h>
#import <AudioToolbox/AudioToolbox.h>

#include <thread>
#include <chrono>

#include <mach/mach_init.h>
#include <mach/thread_policy.h>
#include <mach/thread_act.h>

//#include <mach/sched.h>

#include <pthread.h>

int set_realtime(int period, int computation, int constraint) {
    struct thread_time_constraint_policy ttcpolicy;
    int ret;

    thread_port_t threadport = pthread_mach_thread_np(pthread_self());

    ttcpolicy.period=period; // HZ/160
    ttcpolicy.computation=computation; // HZ/3300;
    ttcpolicy.constraint=constraint; // HZ/2200;
    ttcpolicy.preemptible=1;

    if ((ret=thread_policy_set(threadport,
        THREAD_TIME_CONSTRAINT_POLICY, (thread_policy_t)&ttcpolicy,
        THREAD_TIME_CONSTRAINT_POLICY_COUNT)) != KERN_SUCCESS) {
            fprintf(stderr, "set_realtime() failed.\n");
            return 0;
    }
    return 1;
}

// This workgroup attribute isn't currently used. Set it to NULL.
os_workgroup_attr_t _Nullable attr = nullptr;

// One nanosecond in seconds.
constexpr static double kOneNanosecond = 1.0e9;

// The I/O interval time in seconds.
constexpr static double kIOIntervalTime = 0.020;

// The clock identifier that specifies interval timestamps.
os_clockid_t clockId = OS_CLOCK_MACH_ABSOLUTE_TIME;


// Create a workgroup interval.
os_workgroup_interval_t _Nullable realtimeWorkgroup =
    AudioWorkIntervalCreate("My Work Interval", clockId, attr);

bool joinThisThreadToWorkgroup(os_workgroup_t workgroup);


void realtimeThreadFunction() {


    // it is NECESSARY to have the thread be realtime before it is added to a workgroup
    // please calculate these numbers on your own, they are just placeholders
    // a good place to start is https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KernelProgramming/scheduler/scheduler.html
    // or https://justinfrankel.org/?article=854
    // The second link recommends if you want to match the OSX audio thread to:
    // "a period and constraint of ((1000000000.0 * blocksize * mach_timebase_info().denom) / (mach_timebase_info().numer * srate), and a computation of half that."
    set_realtime(100000, 100000, 50000);


    // Join this thread to the workgroup.
    if (not joinThisThreadToWorkgroup(realtimeWorkgroup))
    {
        // Early return, unable to add this thread to the workgroup
        return;
    }


    // Get the mach time info.
    struct mach_timebase_info timeBaseInfo;
    mach_timebase_info(&timeBaseInfo);


    // The frequency of the clock is: (timeBaseInfo.denom / timeBaseInfo.numer) * kOneNanosecond
    const auto nanoSecFrequency = static_cast<double>(timeBaseInfo.denom) / static_cast<double>(timeBaseInfo.numer);
    const auto frequency = nanoSecFrequency * kOneNanosecond;


    // Convert the interval time in seconds to mach time length.
    const auto intervalMachLength = static_cast<int64_t>(kIOIntervalTime * frequency);
    while (true) {
        // Get the current host time.
        const auto currentTime = mach_absolute_time();
        const auto deadline = currentTime + intervalMachLength;


        // Call os_workgroup_interval_start each time the thread begins a work cycle
        int result = os_workgroup_interval_start(realtimeWorkgroup, currentTime, deadline, nullptr);


        if (result != 0) {
            // Something went wrong.
        }


        // Perform some custom DSP processing.
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
        //customAudioDSP();


        // Call os_workgroup_interval_finish on completion of each a work cycle.
        result = os_workgroup_interval_finish(realtimeWorkgroup, nullptr);
    }
    
    // NOTE: this never leaves the workgroup (or ever exits, that's for you to do :)
}

thread_local os_workgroup_join_token_s joinToken{};

// Return true if the method joined the thread to the workgroup.
bool joinThisThreadToWorkgroup(os_workgroup_t aWorkgroup) {
    // Join this thread to the workgroup.
    const int result = os_workgroup_join(aWorkgroup, &joinToken);
    if (result == 0) {
        return true;
    } else if (result == EALREADY) {
        // The thread is already part of a workgroup that can't be
        // nested in the the specified workgroup.
        assert(false);
        return false;
    } else if (result == EINVAL) {
        // The workgroup has been canceled.
        // OR: The thread you are trying to add is not realtime, you must promote it to realtime
        // see comment in realtimeThreadFunction()
        assert(false);
        return false;
    }
    else
    {
        assert(false);
    }
}

int main()
{
    realtimeThreadFunction();
}