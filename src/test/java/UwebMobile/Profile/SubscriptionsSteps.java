package UwebMobile.Profile;

import Autotest.common.utils.Attacher;
import Autotests.UWeb.pages.APIHelper;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import ru.yandex.qatools.allure.annotations.Step;

import static org.hamcrest.MatcherAssert.assertThat;

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
        assertThat("Блок присутствует, подписок нет", pProfile.isSubscribesBlockDisplayed());
        pProfile.noSubscriptionsBlock();
        Attacher.attachText(pProfile.noSubscriptions(), "Текст блока");
    }

    @Step("Вход пользователем с подписками (метод отдает непустой массив)"
            + "\nОЖИДАЕТСЯ:\n"
            + "Есть подписки")
    public void haveSubscriptions() throws Exception {
        //List<String> subs=api.prepaidAddBalance(login,password,ctn);
        assertThat("Блок присутствует, подписки есть", pProfile.isSubscriptionsDisplayed());
    }

    @Step("Отключение подписки"
            + "\nОЖИДАЕТСЯ:\n"
            + "Подписка отключена")
    public void turnOffSubscriptions() throws Exception {
        //List<String> subs=api.prepaidAddBalance(login,password,ctn);
        pProfile.turnOffSub();
        pProfile.turningOffSub();
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
    }
}
