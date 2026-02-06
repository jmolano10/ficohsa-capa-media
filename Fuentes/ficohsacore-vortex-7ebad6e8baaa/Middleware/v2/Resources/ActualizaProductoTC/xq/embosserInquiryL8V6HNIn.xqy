xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/obtenerTarjetaTitular/xsd/obtenerTarjetaTitular_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmbosserInquiryL8V6Request" location="../../../BusinessServices/VisionPlusHN/vmx/wsdl/VMX.wsdl" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTarjetaTitular";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProductoTC/xq/embosserInquiryL8V6HNIn/";

declare function xf:embosserInquiryL8V6HNIn($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:EmbosserInquiryL8V6Request) {
        <ns0:EmbosserInquiryL8V6Request>
           {
              let $rowBase := $outputParameters1/ns1:RowSet[1]/ns1:Row[ns1:Column/@name = 'TipoOrg' and ns1:Column/text() = 'BASE']
              return
                  (
              	  	  <AZXCII-ORG>{ data($rowBase/ns1:Column[upper-case(@name) = 'ORGANIZACION']) }</AZXCII-ORG>,
              		  <AZXCII-CARD>{ data($rowBase/ns1:Column[upper-case(@name) = 'NUMEROTARJETA']) }</AZXCII-CARD>,
              		  <AZXCII-SEQ>{ data($rowBase/ns1:Column[upper-case(@name) = 'SECUENCIA']) }</AZXCII-SEQ>,
              		  <AZXCII-FOREIGN-USE>0</AZXCII-FOREIGN-USE>
              )
           }
        </ns0:EmbosserInquiryL8V6Request>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:embosserInquiryL8V6HNIn($outputParameters1)