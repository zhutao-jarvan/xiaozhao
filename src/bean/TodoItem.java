package bean;

public class TodoItem {
    private String keywords;
    private String thing;
    private String how;
    private String do_today;
    private String do_tomorrow;
    private String do_later;

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getThing() {
        return thing;
    }

    public void setThing(String thing) {
        this.thing = thing;
    }

    public String getHow() {
        return how;
    }

    public void setHow(String how) {
        this.how = how;
    }

    public String getDo_today() {
        return do_today;
    }

    public void setDo_today(String do_today) {
        this.do_today = do_today;
    }

    public String getDo_tomorrow() {
        return do_tomorrow;
    }

    public void setDo_tomorrow(String do_tomorrow) {
        this.do_tomorrow = do_tomorrow;
    }

    public String getDo_later() {
        return do_later;
    }

    public void setDo_later(String do_later) {
        this.do_later = do_later;
    }
}
