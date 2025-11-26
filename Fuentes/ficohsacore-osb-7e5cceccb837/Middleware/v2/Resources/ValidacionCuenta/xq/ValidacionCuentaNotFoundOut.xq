(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/ValidacionCuentaNotFoundOut/";

declare function xf:ValidacionCuentaNotFoundOut($errorMessage as xs:string,
    $accountNumber as xs:string,
    $accountName as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>NO RECORDS</successIndicator>
            {
            
            if(fn:contains($errorMessage,'Levenshtein')) then(
            		<messages>{ fn:concat('La cuenta: ',$accountNumber," ",$errorMessage,$accountName) }</messages>
            	)
            	else (
            		<messages>{ fn:concat('La cuenta: ',$accountNumber," no es válida. ",$errorMessage) }</messages>
            	)   
            }
        </ns0:ResponseHeader>
};

declare variable $errorMessage as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $accountName as xs:string external;

xf:ValidacionCuentaNotFoundOut($errorMessage,
    $accountNumber,
    $accountName)