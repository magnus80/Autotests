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

@Resource.Classpath("Properties.xlsx")
@WithStatic(ExcelPropertyProviderStatic.class)
@FromSheet.Common("Profile")

public class CACBalanceTests extends BaseScenario {

    static {
        PropertyLoaderStatic.populate(CACBalanceTests.class);
    }

    public CACBalanceSteps cacBalanceSteps =new CACBalanceSteps();

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_Prepaid_Has_CAC")
    private static String LOGIN_CAC_BAL;

    @Title("Профиль")
    @Features("Получение инфо о CAC балансах")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_getCACBalance() throws Exception {
        cacBalanceSteps.login(LOGIN_CAC_BAL,PASSWORD);
        cacBalanceSteps.getCACBalance();
        cacBalanceSteps.addCACBalance();
        cacBalanceSteps.logout();
        //close();
    }

}
