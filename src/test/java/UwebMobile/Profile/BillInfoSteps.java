package UwebMobile.Profile;


import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import org.hamcrest.Matcher;
import ru.yandex.qatools.allure.annotations.Step;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;

public class BillInfoSteps extends ProfileHelper {

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК и скрытие бонусов")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
    }

    @Step("Проверка цвета баланса, цвет: {0}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Цвет баланса корректный")
    public void getColors(String colour) throws Exception {
        pProfile.colorSumFont(colour);
        assertThat(pProfile.colorSumFont(colour), containsString(colour));
        //assertTrue(pProfile.colorSumFont(colour),"Цвет шрифта соответствует");
    }

    @Step("Подключена автооплата"
            + "\nОЖИДАЕТСЯ:\n"
            + "Отображается информер")
    public void getAutooplata() throws Exception {
        assertThat("Блок присутствует", pProfile.isConnectedServicesBlockDisplayed());
        assertThat("Ссылка присутствует", pProfile.isConnectedServicesLinkDisplayed());
        assertThat(pProfile.Autooplata(0),containsString("Автоплатёж"));
        assertThat(pProfile.Autooplata(1),containsString("Автоматическое"));
    }


}
