xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/cargarArchivoDAT/xsd/cargarArchivoDAT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cargaArchivoDATResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargarArchivoDAT";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoDAT/xq/cargaArchivoDATOut/";

declare function xf:cargaArchivoDATOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:cargaArchivoDATResponse) {
        <ns1:cargaArchivoDATResponse>
            <BANK_BATCH_ID>{ data($outputParameters/ns0:PN_SECSOLICITUD) }</BANK_BATCH_ID>
        </ns1:cargaArchivoDATResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:cargaArchivoDATOut($outputParameters)