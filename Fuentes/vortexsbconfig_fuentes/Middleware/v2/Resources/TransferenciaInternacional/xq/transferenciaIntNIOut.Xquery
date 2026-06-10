<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opTransferenciaInternacionalRespuesta" element="ns0:opTransferenciaInternacionalRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalResponse" location="../xsd/transferenciaInternacionalType.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace ns4 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaInternacional/xq/transferenciaIntNIOut/";
declare namespace ns3 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare function xf:transferenciaIntNIOut($opTransferenciaInternacionalRespuesta as element(ns0:opTransferenciaInternacionalRespuesta))
    as element(ns1:transferenciaInternacionalResponse) {
        &lt;ns1:transferenciaInternacionalResponse>
            {
                for $nombreCompleto in $opTransferenciaInternacionalRespuesta/ns3:nombreClienteOrdenante/ns3:nombreCompleto
                return
                    &lt;ORDERING_CUSTOMER>{ fn:replace(data($nombreCompleto),"[Ññ]", "#") }&lt;/ORDERING_CUSTOMER>
            }
        &lt;/ns1:transferenciaInternacionalResponse>
};

declare variable $opTransferenciaInternacionalRespuesta as element(ns0:opTransferenciaInternacionalRespuesta) external;

xf:transferenciaIntNIOut($opTransferenciaInternacionalRespuesta)</con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/transferencia/xsd/services"/>
    </con:dependency>
    <con:dependency location="../xsd/transferenciaInternacionalType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciaInternacional/xsd/transferenciaInternacionalType"/>
    </con:dependency>
</con:xqueryEntry>