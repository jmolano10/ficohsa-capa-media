(:: pragma bea:global-element-parameter parameter="$solicitaUrlSeguraResponse1" element="ns1:SolicitaUrlSeguraResponse" location="../../../BusinessServices/SALESFORCE/generaUrlSegura/xsd/solicitaUrlSegura_1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaUrlGestionesSaleforceResponse" location="../xsd/generaUrlGestionesSaleforceTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/SolicitaUrlSeguraTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaUrlGestionesSaleforceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraUrlGestionesSaleforce/xq/actualizaCredencialesSalesForceV2On/";

declare function xf:actualizaCredencialesSalesForceV2On($solicitaUrlSeguraResponse1 as element(ns1:SolicitaUrlSeguraResponse))
    as element(ns0:generaUrlGestionesSaleforceResponse) {
        <ns0:generaUrlGestionesSaleforceResponse>
            {
                for $UrlSegura in $solicitaUrlSeguraResponse1/UrlSegura
                return
                    <SECURE_URL>{ data($UrlSegura) }</SECURE_URL>
            }
            {
                for $SessId in $solicitaUrlSeguraResponse1/SessId
                return
                    <SESSION_ID>{ data($SessId) }</SESSION_ID>
            }
        </ns0:generaUrlGestionesSaleforceResponse>
};

declare variable $solicitaUrlSeguraResponse1 as element(ns1:SolicitaUrlSeguraResponse) external;

xf:actualizaCredencialesSalesForceV2On($solicitaUrlSeguraResponse1)
