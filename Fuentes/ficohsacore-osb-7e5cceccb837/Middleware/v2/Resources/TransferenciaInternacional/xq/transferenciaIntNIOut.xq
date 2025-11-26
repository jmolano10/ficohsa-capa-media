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
        <ns1:transferenciaInternacionalResponse>
            {
                for $nombreCompleto in $opTransferenciaInternacionalRespuesta/ns3:nombreClienteOrdenante/ns3:nombreCompleto
                return
                    <ORDERING_CUSTOMER>{ data($nombreCompleto) }</ORDERING_CUSTOMER>
            }
        </ns1:transferenciaInternacionalResponse>
};

declare variable $opTransferenciaInternacionalRespuesta as element(ns0:opTransferenciaInternacionalRespuesta) external;

xf:transferenciaIntNIOut($opTransferenciaInternacionalRespuesta)