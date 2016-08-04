package Autotests.UWeb.pages;

import Autotest.common.converters.ByConverter;
import Autotest.common.properties.PropertyLoaderStatic;
import org.openqa.selenium.By;
import ru.yandex.qatools.properties.annotations.Property;
import ru.yandex.qatools.properties.annotations.Resource;
import ru.yandex.qatools.properties.annotations.Use;

@Resource.Classpath("./UWeb/Pages/Page_Messages.properties")

public class Page_Messages extends Helper_my {

    static {
        PropertyLoaderStatic.populate(Autotests.UWeb.pages.Page_Profile.class);
    }

    @Property("Requests_tab")
    @Use(ByConverter.class)
    private static By requests_link;

    @Property("Notices_tab")
    @Use(ByConverter.class)
    private static By notices_link;

    @Property("Subcaption_page")
    @Use(ByConverter.class)
    private static By subcaption;

    public boolean getTitle() {
        return $(requests_link).isDisplayed();
    }

    public boolean isRequestsDisplayed(){
        return $(notices_link).isDisplayed();
    }

    public boolean isNoticesDisplayed(){
        return $(requests_link).isDisplayed();
    }

    public void gotoRequests() {
        $(requests_link).click();
    }

    public void gotoNotices() {
        $(notices_link).click();
    }
}
