package UwebMobile.Profile;

import Autotest.common.utils.Attacher;
import Autotests.UWeb.pages.APIHelper;
import Autotests.UWeb.pages.Page_CurrentPP;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import ru.yandex.qatools.allure.annotations.Step;

public class CurrentPPSteps extends ProfileHelper {

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();
    public Page_CurrentPP cCurrentPP = new Page_CurrentPP();
    public APIHelper api=new APIHelper();

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК и скрытие бонусов")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
    }

    public void logOutFromCurrentPP() {
        pProfile.hideBonus();
        cCurrentPP.logOut();
    }

    @Step("Проверка ссылки на текущий ТП и т.д"
            + "\nОЖИДАЕТСЯ:\n"
            + "Все корректно.")
    public void openedProfile() {
        Attacher.attachText("Ссылка " + pProfile.getCurrentPPLink() + " в наличии", "");
        Attacher.attachText("Система расчётов: " + pProfile.getCurrentPPR(), "");
    }

    /**
     * Переход в карточку текущего тарифа
     */
    @Step("Переход в карточку текущего тарифа"
            + "\nОЖИДАЕТСЯ:\n"
            + "Открыта карточка текущего тарифа.")
    public void goToCurrentPP() {
        pProfile.gotoCurrentPP();
        Attacher.attachText(cCurrentPP.isCardDisplayed(),"");
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
        //WebDriverRunner.getWebDriver().manage().deleteAllCookies();
    }
}
