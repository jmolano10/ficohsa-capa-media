(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreacionArchivoDeDetalle" location="../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudAperturaCuenta/xq/creacionArchivoDetalleIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:creacionArchivoDetalleIn($recordName as xs:string,
    $lineCnt as xs:string,
    $fileStatus as xs:string,
    $agency as xs:string,
    $requestHeader as element(ns1:RequestHeader))
    as element(ns0:CreacionArchivoDeDetalle) {
        <ns0:CreacionArchivoDeDetalle>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOBULKFILEDETINPUTWSType id = "{ $recordName }">
                <UPDATE>{ fn-bea:date-to-string-with-format("yyyyMMdd", fn:adjust-date-to-timezone(fn:current-date(), ())) }</UPDATE>
                <LINECNT>{ $lineCnt }</LINECNT>
                <FILESTATUS>{ $fileStatus }</FILESTATUS>
                <UPLOADUSER>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</UPLOADUSER>
                <DELETEDATE>{ fn-bea:date-to-string-with-format("yyyyMMdd", fn:adjust-date-to-timezone(fn:current-date() + xdt:dayTimeDuration("P10D"), ())) }</DELETEDATE>
                <AGENCY>{ $agency }</AGENCY>
            </FICOBULKFILEDETINPUTWSType>
        </ns0:CreacionArchivoDeDetalle>
};

declare variable $recordName as xs:string external;
declare variable $lineCnt as xs:string external;
declare variable $fileStatus as xs:string external;
declare variable $agency as xs:string external;
declare variable $requestHeader as element(ns1:RequestHeader) external;

xf:creacionArchivoDetalleIn($recordName,
    $lineCnt,
    $fileStatus,
    $agency,
    $requestHeader)