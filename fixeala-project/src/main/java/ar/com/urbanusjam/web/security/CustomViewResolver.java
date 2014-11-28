package ar.com.urbanusjam.web.security;

import java.util.Locale;

import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;


public class CustomViewResolver extends UrlBasedViewResolver {

    public static String REDIRECT_URL_PREFIX_NO_MODEL = "redirect-no-model:";
    public static String REDIRECT_URL_PREFIX_PERMANENTLY = "redirect-permanently:";

    @Override
    protected View createView(String viewName, Locale locale) throws Exception {
        // If this resolver is not supposed to handle the given view,
        // return null to pass on to the next resolver in the chain.
        if (!canHandle(viewName, locale)) {
            return null;
        }
        // Check for special "redirect:" prefix.
        if (viewName.startsWith(REDIRECT_URL_PREFIX_PERMANENTLY)) {
            String redirectUrl = viewName.substring(REDIRECT_URL_PREFIX_PERMANENTLY.length());
            RedirectView rv =  new RedirectView(redirectUrl, isRedirectContextRelative(), false);
            rv.setExposeModelAttributes(false);
            rv.setStatusCode(HttpStatus.MOVED_PERMANENTLY);
            return rv;
        }
        if (viewName.startsWith(REDIRECT_URL_PREFIX_NO_MODEL)) {
            String redirectUrl = viewName.substring(REDIRECT_URL_PREFIX_NO_MODEL.length());
            RedirectView rv =  new RedirectView(redirectUrl, isRedirectContextRelative(), isRedirectHttp10Compatible());
            rv.setExposeModelAttributes(false);
            return rv;
        }
        return super.createView(viewName, locale);
    }


}