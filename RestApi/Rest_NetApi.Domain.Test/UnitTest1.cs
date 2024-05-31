namespace Rest_NetApi.Domain.Test;

public class UnitTest1
{
    [Fact]
    public void Test1()
    {
     if(sum(2, 6) != 4)
        {
            throw new Exception();
        }

    }


    public int sum(int a, int b)
    {
        return a + b;
    } 
}