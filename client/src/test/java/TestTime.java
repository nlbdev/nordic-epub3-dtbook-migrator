import org.daisy.validator.Util;
import org.junit.Assert;
import org.junit.Test;

public class TestTime {
    @Test
    public void testTime() {
        Assert.assertEquals("Test longform" ,600100, Util.parseMilliSeconds("00:10:00.100"));
        Assert.assertEquals("Test shortform" ,600100, Util.parseMilliSeconds("10:00.100"));
        Assert.assertEquals("Test only seconds" ,1100, Util.parseMilliSeconds("01.100"));
        Assert.assertEquals("Test second extension" ,100000, Util.parseMilliSeconds("100s"));
        Assert.assertEquals("Test millisecond extension" ,100, Util.parseMilliSeconds("100ms"));
        Assert.assertEquals("Test hour extension" ,3600000, Util.parseMilliSeconds("1h"));
        Assert.assertEquals("Test minute extension" ,60000, Util.parseMilliSeconds("1min"));
        Assert.assertEquals("Test second with decimals" ,100200, Util.parseMilliSeconds("100.2s"));
        Assert.assertEquals("Test millisecond with decimals" ,100, Util.parseMilliSeconds("100.3ms"));
        Assert.assertEquals("Test hours with decimals" ,5040000, Util.parseMilliSeconds("1.4h"));
        Assert.assertEquals("Test minuties with decimals" ,66000, Util.parseMilliSeconds("1.1min"));
    }
}
