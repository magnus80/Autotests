package UwebMobile.Profile;

import Autotests.UWeb.pages.APIHelper;
import Autotests.UWeb.pages.Page_CurrentPP;
import Autotests.UWeb.pages.Page_Login;
import Autotests.UWeb.pages.Page_Profile;
import org.testng.Assert;
import ru.yandex.qatools.allure.annotations.Step;

import java.io.IOException;
import java.util.List;

public class AdditionalBalancesSteps extends ProfileHelper {

    public Page_Login pLogin = new Page_Login();
    public Page_Profile pProfile = new Page_Profile();
    public Page_CurrentPP cCurrentPP = new Page_CurrentPP();
    public APIHelper api = new APIHelper();

    @Step("Вход в ЛК по логину и паролю {0} {1}"
            + "\nОЖИДАЕТСЯ:\n"
            + "Вход в ЛК и скрытие бонусов")
    public void login(String login, String password) throws Exception {
        pLogin.openLoginPage();
        pLogin.login(login, password);
        pProfile.hideBonus();
    }

    @Step("Проверка отсутствия блока допбалансов"
            + "\nОЖИДАЕТСЯ:\n"
            + "Допбалансы отсутствуют.")
    public void addBalanceLCOut() throws Exception {
        pProfile.logOut();
    }

    @Step("")
    public void apiAddBalances(String login,String password,String ctn) throws IOException {
        List<String> min=api.prepaidAddBalance(login,password,ctn);
    }

    @Step("\"Проверка отсутствия блока допбалансов"
            +"\nОЖИДАЕТСЯ:\n"
            +"Допбалансы присутствуют.")
    public void addBalancesLC() throws IOException {
        //pProfile.addBalWidget();
    }

    @Step("\"Проверка присутствия блока САС"
            +"\nОЖИДАЕТСЯ:\n"
            +"Баланс САС присутствует.")

    public void step2_CAC() throws IOException {
        //pProfile.addBalWidget();
    }

    @Step("Выход из ЛК"
            + "\nОЖИДАЕТСЯ:\n"
            + "ЛК закрыт.")
    public void logout() throws Exception {
        pProfile.logOut();
    }

}
