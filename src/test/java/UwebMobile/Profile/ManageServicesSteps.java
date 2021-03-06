package UwebMobile.Profile;

import Autotests.UWeb.pages.APIHelper;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import org.testng.Assert;
import ru.yandex.qatools.allure.annotations.Step;

public class ManageServicesSteps extends ProfileHelper {
    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();
    public APIHelper api = new APIHelper();

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК и скрытие бонусов")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
    }


    @Step("Получение списка услуг по АПИ"
            + "\nОЖИДАЕТСЯ:\n"
            + "")
    public void getServiceList(String login, String password, String ctn) throws Exception {
        Assert.assertTrue(pProfile.isConnectedServicesBlockDisplayed(), "Элемент не найден");
        //api.serviceList(login,password,ctn);
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
    }

}
