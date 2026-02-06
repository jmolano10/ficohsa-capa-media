xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoSolicitud" element="ns0:pagoRecaudoSolicitud" location="../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)
(:: pragma  parameter="$responseXml" type="anyType" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/TercerosNI/registraBitacoraEnrutador/xsd/RegistraBitacoraNI_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistraBitacoraNI";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoNI/xq/registraPagoRecaudoIn/";

declare function xf:registraPagoRecaudoIn($pagoRecaudoSolicitud as element(ns0:pagoRecaudoSolicitud),
    $userName as xs:string,
    $codOperation as xs:decimal,
    $responseXml as element(*))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCANAL>{ $userName }</ns2:PV_CODIGOCANAL>
            {
                for $contractId in $pagoRecaudoSolicitud/ns1:contractId
                return
                    <ns2:PV_IDCONVENIO>{ data($contractId) }</ns2:PV_IDCONVENIO>
            }
            {
                for $debtorCode in $pagoRecaudoSolicitud/ns1:debtorCode
                return
                    <ns2:PV_CODIGODEUDOR>{ data($debtorCode) }</ns2:PV_CODIGODEUDOR>
            }
            <ns2:PN_CODIGOOPERACION>{ $codOperation }</ns2:PN_CODIGOOPERACION>
            {
                for $paymentCurrency in $pagoRecaudoSolicitud/ns1:paymentInformation/ns1:paymentCurrency
                return
                    <ns2:PV_MONEDA>{ data($paymentCurrency) }</ns2:PV_MONEDA>
            }
            {
                for $paymentAmount in $pagoRecaudoSolicitud/ns1:paymentInformation/ns1:paymentAmount
                return
                    <ns2:PN_MONTOTOTAL>{ data($paymentAmount) }</ns2:PN_MONTOTOTAL>
            }
            <ns2:PC_SOLICITUDENVIADA>{ $pagoRecaudoSolicitud/@* , $pagoRecaudoSolicitud/node() }</ns2:PC_SOLICITUDENVIADA>
            <ns2:PC_SOLICITUDRECIBIDA>{ $responseXml/@* , $responseXml/node() }</ns2:PC_SOLICITUDRECIBIDA>
        </ns2:InputParameters>
};

declare variable $pagoRecaudoSolicitud as element(ns0:pagoRecaudoSolicitud) external;
declare variable $userName as xs:string external;
declare variable $codOperation as xs:decimal external;
declare variable $responseXml as element(*) external;

xf:registraPagoRecaudoIn($pagoRecaudoSolicitud,
    $userName,
    $codOperation,
    $responseXml)