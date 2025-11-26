(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/Fiscan/xsd/ConsultaClienteFiscan_db_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaClienteFiscan_db";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/ValidaDatosClienteFiscanIN/";

declare function xf:ValidaDatosClienteFiscanIN($Country as xs:string,
    $User as xs:string,
    $TrxCode as xs:string,
    $Channel as xs:string,
    $Date as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_pais>{ $Country }</ns0:i_pais>
            <ns0:i_canal>{ $Channel }</ns0:i_canal>
            <ns0:i_user>{ $User }</ns0:i_user>
            <ns0:i_fecha>{ data($Date) }</ns0:i_fecha>
            <ns0:i_oficina></ns0:i_oficina>
            <ns0:t_trn>{ data($TrxCode) }</ns0:t_trn>
        </ns0:InputParameters>
};

declare variable $Country as xs:string external;
declare variable $User as xs:string external;
declare variable $TrxCode as xs:string external;
declare variable $Channel as xs:string external;
declare variable $Date as xs:string external;

xf:ValidaDatosClienteFiscanIN($Country,
    $User,
    $TrxCode,
    $Channel,
    $Date)
