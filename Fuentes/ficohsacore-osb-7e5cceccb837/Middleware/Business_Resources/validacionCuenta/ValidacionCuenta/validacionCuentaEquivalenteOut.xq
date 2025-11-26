(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaResponse" location="validacionCuentaType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaEquivalenteOut2/";

declare function xf:validacionCuentaEquivalenteOut2($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse),
    $accountNumber as xs:string)
    as element(ns1:validacionCuentaResponse) {
        <ns1:validacionCuentaResponse>
            <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
            {
                for $SHORTTITLE in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
                return
                    <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
                    <ACCOUNT_STATUS>ACTIVE</ACCOUNT_STATUS>
        </ns1:validacionCuentaResponse>
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $accountNumber as xs:string external;

xf:validacionCuentaEquivalenteOut2($consultadedetallesdelacuentaResponse1,
    $accountNumber)