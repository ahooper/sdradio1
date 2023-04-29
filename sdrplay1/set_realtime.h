//
//  set_realtime.h
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-16.
//

#ifndef set_realtime_h
#define set_realtime_h

/// Enable time-contraint policy and priority suitable for low-latency,
/// glitch-resistant audio.
/// - Parameter work_period: The period of intended work cycle in Seconds - the
///                          playout time of the audio buffer
extern int set_realtime(double work_period);

#endif /* set_realtime_h */
