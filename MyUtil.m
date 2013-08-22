
//MyUtil.m

/**
 * 8桁の数字(NSNumber)から月/日を取得する
 * @param dateValue YYYYMMDD
 * @return {NSString} MM/DD
 */
+ (NSString *)stringMonthDay:(NSNumber *)dateValue
{
    NSString *val = [NSString stringWithFormat:@"%08d",
        dateValue.integerValue];
    NSString *ret = [NSString stringWithFormat:@"%@/%@",
        [val substringWithRange: NSMakeRange(4, 2)],
        [val substringWithRange: NSMakeRange(6, 2)]];
    return ret;
}

/**
 * 4桁の数字(NSNumber)から時:分を取得する
 * @param timeValue HHMM
 * @return {NSString} HH:MM
 */
+ (NSString *)stringHourMinute:(NSNumber *)timeValue
{
    NSString *val = [NSString stringWithFormat:@"%04d",
        timeValue.integerValue];
    NSString *ret = [NSString stringWithFormat:@"%@:%@"
        [val substringWithRange: NSMakeRange(0, 2)],
        [val substringWithRange: NSMakeRange(2, 2)]];
    return ret;
}

/**
 * NSDateからNSDateComponentを生成する
 */
+ (NSDateComponent *)dateComponentFromDate:(NSDate *)date
{
    NSCalender *c = [NSCalender currentCalender];
    //todo
}




