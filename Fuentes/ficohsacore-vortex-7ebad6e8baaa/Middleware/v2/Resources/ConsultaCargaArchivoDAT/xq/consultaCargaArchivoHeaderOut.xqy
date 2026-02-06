xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaCargaArchivoDAT/xsd/consultaCargaArchivoDAT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCargaArchivoDAT";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargaArchivoDAT/xq/consultaCargaArchivoHeaderOut/";

declare function xf:consultaCargaArchivoHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_CODRESPUESTA in $outputParameters1/ns1:PV_CODRESPUESTA
                return
                    <successIndicator>{ data($PV_CODRESPUESTA) }</successIndicator>
            }
            {
                for $PV_MSJRESPUESTA in $outputParameters1/ns1:PV_MSJRESPUESTA
                return
                    <messages>{ data($PV_MSJRESPUESTA) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaCargaArchivoHeaderOut($outputParameters1)