func debug(obj: AnyObject?, function: String = __FUNCTION__, line: Int = __LINE__) {
    #if DEBUG
        print("[Function:\(function) Line:\(line)] : \(obj)")
    #endif
}