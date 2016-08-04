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

public class SubscriptionsTests extends BaseScenario {
    static {
        PropertyLoaderStatic.populate(SubscriptionsTests.class);
    }

    public SubscriptionsSteps subscriptionsSteps =new SubscriptionsSteps();

    @Property("Password")
    private static String PASSWORD;
    @Property("Login_Subs")
    private static String LOGIN_SUBS;
    @Property("Login_PP_Prepaid")
    private static String LOGIN_NO_SUBS;
    @Property("CTN_PP_PREPAID")
    private static String CTN_PP_PREPAID;

    @Title("Профиль")
    @Features("Подписки")
    @Stories({"Sanity", "Профиль"})
    @Test(groups = {"All_tests", "UWebtest"})
    public void test_getAdditionalBalances() throws Exception {
        subscriptionsSteps.login(LOGIN_NO_SUBS,PASSWORD);
        subscriptionsSteps.noSubscriptions();
        subscriptionsSteps.logout();
        close();
    }

}
