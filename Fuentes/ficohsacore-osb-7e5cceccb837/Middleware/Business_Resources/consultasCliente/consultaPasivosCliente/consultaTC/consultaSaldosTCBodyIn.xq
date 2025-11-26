(:: pragma bea:global-element-parameter parameter="$tarjetasdecreditoporclienteResponse1" element="ns0:TarjetasdecreditoporclienteResponse" location="../../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldosTarjetaCredito" location="../../../tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaSaldosTCBodyIn/";

declare function xf:consultaSaldosTCBodyIn($tarjetasdecreditoporclienteResponse1 as element(ns0:TarjetasdecreditoporclienteResponse),
    $counter as xs:integer)
    as element(ns1:consultaSaldosTarjetaCredito) {
        <ns1:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ data($tarjetasdecreditoporclienteResponse1/FICOLISTCLIENTCARDCPType[1]/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType[STATUS!="29 - TARJETA DADA DE BAJA" and CATEGORY!="Additional"][xs:integer($counter)]/CARDNO) }</CARD_NUMBER>
        </ns1:consultaSaldosTarjetaCredito>
};

declare variable $tarjetasdecreditoporclienteResponse1 as element(ns0:TarjetasdecreditoporclienteResponse) external;
declare variable $counter as xs:integer external;

xf:consultaSaldosTCBodyIn($tarjetasdecreditoporclienteResponse1,
    $counter)