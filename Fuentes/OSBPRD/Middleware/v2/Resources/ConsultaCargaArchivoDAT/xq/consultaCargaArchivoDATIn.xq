(:: pragma bea:global-element-parameter parameter="$consultaCargaArchivoDAT1" element="ns0:consultaCargaArchivoDAT" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultaCargaArchivoDAT/xsd/consultaCargaArchivoDAT_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCargaArchivoDAT";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargaArchivoDAT/xq/consultaCargaArchivoDATIn/";

declare function xf:consultaCargaArchivoDATIn($consultaCargaArchivoDAT1 as element(ns0:consultaCargaArchivoDAT))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:PN_IDSOLICITUD>{ data($consultaCargaArchivoDAT1/FILE_REQUEST_ID) }</ns1:PN_IDSOLICITUD>
        </ns1:InputParameters>
};

declare variable $consultaCargaArchivoDAT1 as element(ns0:consultaCargaArchivoDAT) external;

xf:consultaCargaArchivoDATIn($consultaCargaArchivoDAT1)