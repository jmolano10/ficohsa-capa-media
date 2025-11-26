xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../XSD/ConsultaListaNoFATCA/XMLSchema_-531907416.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
(:: import schema at "../XSD/ConsultaListaNoFATCA/ConsultaClienteNoFatca_PS.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/ConsultaListaNoFatcaOut";

declare variable $successIndicator as xs:string external;
declare variable $consultadeclientesnoFATCAResponse as element() (:: schema-element(ns1:ConsultadeclientesnoFATCAResponse) ::) external;

declare function ns2:consultaListaNoFatcaOut($successIndicator as xs:string, 
                                             $consultadeclientesnoFATCAResponse as element() (:: schema-element(ns1:ConsultadeclientesnoFATCAResponse) ::)) 
                                             as element() (:: schema-element(ns3:sjConsultaListasClienteResponse) ::) {
    <ns3:sjConsultaListasClienteResponse>
        <ns3:consultaListaClienteResponse>
            <ns3:successIndicator>{fn:data($successIndicator)}</ns3:successIndicator>
            <ns3:ASSOCIATION_NAME>NOFATCA</ns3:ASSOCIATION_NAME>
            {
                  for $NumeroCliente in $consultadeclientesnoFATCAResponse/WSFICONOFATCAType[1]/gWSFICONOFATCADetailType/mWSFICONOFATCADetailType[1]/NumeroCliente
                  return
                      <ns3:CUSTOMER_ID>{ data($NumeroCliente) }</ns3:CUSTOMER_ID>
              }
              {
                  for $NombreCliente in $consultadeclientesnoFATCAResponse/WSFICONOFATCAType[1]/gWSFICONOFATCADetailType/mWSFICONOFATCADetailType[1]/NombreCliente
                  return
                      <ns3:CUSTOMER_NAME>{ data($NombreCliente) }</ns3:CUSTOMER_NAME>
              }
        </ns3:consultaListaClienteResponse>
    </ns3:sjConsultaListasClienteResponse>
};

ns2:consultaListaNoFatcaOut($successIndicator, $consultadeclientesnoFATCAResponse)
