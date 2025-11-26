(:: pragma bea:global-element-parameter parameter="$retiroEfectivo" element="ns1:retiroEfectivo" location="../xsd/retiroEfectivoCBTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadesaldodecuentaResponse" element="ns0:ConsultadesaldodecuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroEfectivoResponse" location="../xsd/retiroEfectivoCBTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionesCB";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoOut/";

declare function xf:retiroEfectivoOut($comision as xs:string, $retiroEfectivo as element(ns1:retiroEfectivo),
    $consultadesaldodecuentaResponse as element(ns0:ConsultadesaldodecuentaResponse))
    as element(ns1:retiroEfectivoResponse) {
        <ns1:retiroEfectivoResponse>
            <ACCOUNT_NUMBER>{ data($retiroEfectivo/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <AMOUNT>{ data($retiroEfectivo/AMOUNT) }</AMOUNT>
            <CURRENCY>{ data($retiroEfectivo/CURRENCY) }</CURRENCY>
            {
                for $ACCOUNTTITLE in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/ACCOUNTTITLE
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTTITLE) }</ACCOUNT_NAME>
            }
            <TOKEN_ID>{ data($retiroEfectivo/TOKEN_ID) }</TOKEN_ID>
            <COMMISION_AMOUNT>{ $comision }</COMMISION_AMOUNT>
        </ns1:retiroEfectivoResponse>
};
declare variable $comision as xs:string external;
declare variable $retiroEfectivo as element(ns1:retiroEfectivo) external;
declare variable $consultadesaldodecuentaResponse as element(ns0:ConsultadesaldodecuentaResponse) external;

xf:retiroEfectivoOut($comision, $retiroEfectivo,
    $consultadesaldodecuentaResponse)