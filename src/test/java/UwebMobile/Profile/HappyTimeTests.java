package UwebMobile.Profile;

import Autotest.common.properties.ExcelPropertyProviderStatic;
import Autotest.common.properties.FromSheet;
import Autotest.common.properties.PropertyLoaderStatic;
import Autotest.common.properties.WithStatic;
import Autotest.common.supers.BaseScenario;
import org.testng.annotations.Test;
import ru.yandex.qatools.allure.annotations.Features;
import ru.yandex.qatools.allure.annotations.Stories;
import ru.yandex.qatools.allure.annotations.Title;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;

import static com.codeborne.selenide.Selenide.close;

@Resource.Classpath("Properties.xlsx")
@WithStatic(ExcelPropertyProviderStatic.class)
@FromSheet.Common("Profile")

public class HappyTimeTests extends BaseScenario {

    static {
        PropertyLoaderStatic.populate(HappyTimeTests.class);
    }

    public HappyTimeSteps happyTimeSteps =new HappyTimeSteps();

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_Prepaid_Has_HappyTime")
    private static String LOGIN_HT;
    @Property("Login_Prepaid_Has_HappyTime_0")
    private static String LOGIN_HT_0;

    @Title("Профиль")
    @Features("Баланс Счастливого времени")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_getCACBalance() throws Exception {
/*        happyTimeSteps.login(LOGIN_HT_0,PASSWORD);
        happyTimeSteps.noHappyTimeTransfer();
        happyTimeSteps.logout();*/
        happyTimeSteps.login(LOGIN_HT,PASSWORD);
        happyTimeSteps.happyTimeTransfer();
        happyTimeSteps.happyTimeTransferSucceceful();
        close();
    }

}
