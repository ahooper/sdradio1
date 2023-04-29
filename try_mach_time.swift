import Darwin
var timebaseInfo = mach_timebase_info_data_t()
mach_timebase_info(&timebaseInfo)
print(timebaseInfo)
let start=mach_absolute_time();sleep(1);let stop=mach_absolute_time()
print(stop-start)
print((stop-start) * UInt64(timebaseInfo.numer) / UInt64(timebaseInfo.denom) / 1000000, "μSec")
