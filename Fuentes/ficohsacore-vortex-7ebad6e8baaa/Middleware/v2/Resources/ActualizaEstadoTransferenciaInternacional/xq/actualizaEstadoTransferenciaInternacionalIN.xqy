xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$actualizaEstadoTransferenciaInternacional" element="ns0:actualizaEstadoTransferenciaInternacional" location="../xsd/actualizaEstadoTransferenciaInternacionalTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizacionEstadoTransferenciaInternacional/xq/actualizaEstadoTransferenciaInternacionalIN/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTransferenciaInternacionalTypes";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.transactionscustom";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns6 = "urn:infocorp.framework.common";


declare function xf:actualizaEstadoTransferenciaInternacionalIN($actualizaEstadoTransferenciaInternacional as element(ns0:actualizaEstadoTransferenciaInternacional))
    as element(*) {
        <ns3:UpdateTransactionMessageIn>
        	<ns3:BackendReference>{ data($actualizaEstadoTransferenciaInternacional/BACKEND_REFERENCE) }</ns3:BackendReference>
        	<ns3:ErrorBackendCode>{ data($actualizaEstadoTransferenciaInternacional/ERROR_BACKEND_CODE) }</ns3:ErrorBackendCode>
        	<ns3:ExchangeRate>{ data($actualizaEstadoTransferenciaInternacional/EXCHANGE_RATE) }</ns3:ExchangeRate>
        	<ns3:MathOperator>{ data($actualizaEstadoTransferenciaInternacional/MATH_OPERATOR) }</ns3:MathOperator>
        	<ns3:Status>{ data($actualizaEstadoTransferenciaInternacional/STATUS) }</ns3:Status>
			<ns3:TransactionId>{ data($actualizaEstadoTransferenciaInternacional/TRANSACTION_ID) }</ns3:TransactionId>
			<ns3:Type>{ data($actualizaEstadoTransferenciaInternacional/TYPE) }</ns3:Type>
      	</ns3:UpdateTransactionMessageIn>
};

declare variable $actualizaEstadoTransferenciaInternacional as element(ns0:actualizaEstadoTransferenciaInternacional) external;

xf:actualizaEstadoTransferenciaInternacionalIN($actualizaEstadoTransferenciaInternacional)