xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultacuentasdeorigendisponibResponse" element="ns0:ConsultacuentasdeorigendisponibResponse" location="../../../BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentasDisponiblesResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaCuentasDisponiblesOut/";

declare function xf:consultaCuentasDisponiblesOut($consultacuentasdeorigendisponibResponse as element(ns0:ConsultacuentasdeorigendisponibResponse))
    as element(ns1:consultaCuentasDisponiblesResponse) {
        <ns1:consultaCuentasDisponiblesResponse>
            <LISTA_CUENTAS_ORIGEN>
                {
                    for $ACCOUNT in $consultacuentasdeorigendisponibResponse/WSFICOHNACCTCRRYType[1]/gWSFICOHNACCTCRRYDetailType/mWSFICOHNACCTCRRYDetailType
                    return
                        <CUENTA_ORIGEN>{ data($ACCOUNT/ACCOUNTNUMBER) }</CUENTA_ORIGEN>
                }
            </LISTA_CUENTAS_ORIGEN>
        </ns1:consultaCuentasDisponiblesResponse>
};

declare variable $consultacuentasdeorigendisponibResponse as element(ns0:ConsultacuentasdeorigendisponibResponse) external;

xf:consultaCuentasDisponiblesOut($consultacuentasdeorigendisponibResponse)