package UwebMobile.Profile;

import Autotest.common.utils.Attacher;
import Autotests.UWeb.pages.APIHelper;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import ru.yandex.qatools.allure.annotations.Step;

import java.util.List;

public class SubscriptionsSteps extends ProfileHelper {

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

    @Step("Вход пользователем без подписок (метод отдает пустой массив)"
            + "\nОЖИДАЕТСЯ:\n"
            + "У вас нет ни одной подписки")
    public void noSubscriptions() throws Exception {
        //List<String> subs=api.prepaidAddBalance(login,password,ctn);
        Attacher.attachText(pProfile.noSubscriptions(),"");
    }

    @Step("Вход пользователем с подписками (метод отдает непустой массив)"
            + "\nОЖИДАЕТСЯ:\n"
            + "У вас нет ни одной подписки")
    public void haveSubscriptions() throws Exception {
        //List<String> subs=api.prepaidAddBalance(login,password,ctn);

    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
    }
}
