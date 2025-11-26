(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../xsd/consultaRecaudoEEHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DatosHNConsulta" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHSOAP.wsdl" ::)

declare namespace ns0 = "http://schemas.servicestack.net/types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace con = "http://schemas.enee-pay.hn/contract";

declare function local:crearPeticion(
  $consultaRecaudo as element(ns1:consultaRecaudo)
) as element(*) {
	      <con:SaldoRequest xmlns:con="http://schemas.enee-pay.hn/contract">
	        <con:ClavePrimaria>{ data($consultaRecaudo/DEBTOR_CODE)}</con:ClavePrimaria>
	      </con:SaldoRequest>
};

declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;

local:crearPeticion(
  $consultaRecaudo
)