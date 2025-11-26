xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace tem="http://tempuri.org/";
(:: import schema at "../../../../../ProviderServices/WSDL/GetDataBurosPreCredit/v1.0/precalificacion.wsdl" ::)
  declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/GetDataBurosPreCreditGT_BS";
(:: import schema at "../../../../../ProviderServices/XSD/GetDataBurosPreCredit/v1.0/GetDataBurosPreCreditGT_BS.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $getDataBurosPreCreditGTRequest as element() (:: schema-element(ns1:getDataBurosPreCreditGTRequest) ::) external;

declare function xq:Tx_GetCreditOffers_To_BLAZE($getDataBurosPreCreditGTRequest as element() (:: schema-element(ns1:getDataBurosPreCreditGTRequest) ::)) as element() (:: schema-element(tem:ConsultaBuros) ::) {
          <tem:ConsultaBuros>
         <tem:MSGPRE>
            <tem:HEADER>
               <tem:KEY>{fn:data($getDataBurosPreCreditGTRequest/ns1:KEY)}</tem:KEY>
               <tem:CODIGO_PROSPECTO>{fn:data($getDataBurosPreCreditGTRequest/ns1:CODIGO_PROSPECTO)}</tem:CODIGO_PROSPECTO>
                {
                    if ($getDataBurosPreCreditGTRequest/ns1:CODIGO_EMPRESA)
                    then <tem:CODIGO_EMPRESA>{fn:data($getDataBurosPreCreditGTRequest/ns1:CODIGO_EMPRESA)}</tem:CODIGO_EMPRESA>
                    else ()
                }
               <tem:RELACION_PROSPECTO>{fn:data($getDataBurosPreCreditGTRequest/ns1:RELACION_PROSPECTO)}</tem:RELACION_PROSPECTO>
               <tem:TIPO_PERSONA>{fn:data($getDataBurosPreCreditGTRequest/ns1:TIPO_PERSONA)}</tem:TIPO_PERSONA>
               <tem:CODIGO_PRODUCTO>{fn:data($getDataBurosPreCreditGTRequest/ns1:CODIGO_PRODUCTO)}</tem:CODIGO_PRODUCTO>
               <tem:USUARIO>{fn:data($getDataBurosPreCreditGTRequest/ns1:USUARIO)}</tem:USUARIO>
               <tem:REFERENCIA></tem:REFERENCIA>
               <tem:PC>{fn:data($getDataBurosPreCreditGTRequest/ns1:PC)}</tem:PC>
               <tem:IP>{fn:data($getDataBurosPreCreditGTRequest/ns1:IP)}</tem:IP>
            </tem:HEADER>
            <tem:BODY>
               <tem:NIT>{fn:data($getDataBurosPreCreditGTRequest/ns1:NIT)}</tem:NIT>
               <tem:PRIMER_NOMBRE>{fn:data($getDataBurosPreCreditGTRequest/ns1:PRIMER_NOMBRE)}</tem:PRIMER_NOMBRE>
               <tem:SEGUNDO_NOMBRE>{fn:data($getDataBurosPreCreditGTRequest/ns1:SEGUNDO_NOMBRE)}</tem:SEGUNDO_NOMBRE>
               <tem:PRIMER_APELLIDO>{fn:data($getDataBurosPreCreditGTRequest/ns1:PRIMER_APELLIDO)}</tem:PRIMER_APELLIDO>
               <tem:SEGUNDO_APELLIDO>{fn:data($getDataBurosPreCreditGTRequest/ns1:SEGUNDO_APELLIDO)}</tem:SEGUNDO_APELLIDO>
               <tem:PASAPORTE>{fn:data($getDataBurosPreCreditGTRequest/ns1:PASAPORTE)}</tem:PASAPORTE>
               <tem:PAIS_PASAPORTE>{fn:data($getDataBurosPreCreditGTRequest/ns1:PAIS_PASAPORTE)}</tem:PAIS_PASAPORTE>
               <tem:DPI>{fn:data($getDataBurosPreCreditGTRequest/ns1:DPI)}</tem:DPI>
               <tem:FECHA_NACIMIENTO>{fn:data($getDataBurosPreCreditGTRequest/ns1:FECHA_NACIMIENTO)}</tem:FECHA_NACIMIENTO>
            </tem:BODY>
         </tem:MSGPRE>
      </tem:ConsultaBuros>    
};

xq:Tx_GetCreditOffers_To_BLAZE($getDataBurosPreCreditGTRequest)