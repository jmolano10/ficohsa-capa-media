(:: pragma bea:global-element-parameter parameter="$actualizaEstadoRemesaRequest" element="ns1:actualizaEstadoRemesaRequest" location="../xsd/actualizaEstadoRemesa.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Terceros/xsd/registraBitacoraTerceroEncabezado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTerceroEncabezado";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoRemesaTypes/v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerRegistraBitacoraTerceroEncabezadoIn/";

declare function xf:aerRegistraBitacoraTerceroEncabezadoIn($actualizaEstadoRemesaRequest as element(ns1:actualizaEstadoRemesaRequest),
    $uuid as xs:string,
    $contractId as xs:string,
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ $uuid }</ns0:PV_ID>
            <ns0:PV_PRIMARYKEY>{ data($actualizaEstadoRemesaRequest/REMITTANCE_ID) }</ns0:PV_PRIMARYKEY>
            <ns0:PV_TRANSACTIONCODE>5</ns0:PV_TRANSACTIONCODE>
            <ns0:PV_CONTRACTNUMBER>{ $contractId }</ns0:PV_CONTRACTNUMBER>
            <ns0:PV_TRANSACTIONCHANNEL>{ $userName }</ns0:PV_TRANSACTIONCHANNEL>
            <ns0:PV_TRANSACTIONUSER>{ $userName }</ns0:PV_TRANSACTIONUSER>
            <ns0:PN_TRANSACTIONAMOUNT>0</ns0:PN_TRANSACTIONAMOUNT>
            <ns0:PV_DUEDATE>{ fn-bea:dateTime-to-string-with-format("yyMMddHHmm", fn-bea:dateTime-from-string-with-format("yyyy-MM-dd-HH:mm", concat(fn:current-date()))) }</ns0:PV_DUEDATE>
        </ns0:InputParameters>
};

declare variable $actualizaEstadoRemesaRequest as element(ns1:actualizaEstadoRemesaRequest) external;
declare variable $uuid as xs:string external;
declare variable $contractId as xs:string external;
declare variable $userName as xs:string external;

xf:aerRegistraBitacoraTerceroEncabezadoIn($actualizaEstadoRemesaRequest,
    $uuid,
    $contractId,
    $userName)
