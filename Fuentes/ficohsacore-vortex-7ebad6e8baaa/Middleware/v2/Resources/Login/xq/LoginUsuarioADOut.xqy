xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MDW/LoginUsuarioAD/LogueoAD/xsd/LoguearUsuarioAD_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:loginResponse" location="../xsd/loginTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/LoguearUsuarioAD";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Login/xq/LoginUsuarioADOut/";

declare function obtieneToken($listaCampos as xs:string, $listaValores as xs:string, $campo as xs:string) as xs:string {
    let $LISTA_CAMPOS := fn:tokenize($listaCampos, "\|\|")
    let $LISTA_VALORES := fn:tokenize($listaValores, "\|\|")
    let $POSICION := fn:index-of($LISTA_CAMPOS,$campo)
    return
        if (fn:exists($POSICION)) then 
        (
            $LISTA_VALORES[$POSICION[1]]
        ) 
        else ("")
};

declare function xf:LoginUsuarioADOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:loginResponse) {
<ns0:loginResponse>
	<PROFILE>{ obtieneToken(data($outputParameters1/ns1:RSP_ATTR_NAMES),data($outputParameters1/ns1:RSP_ATTR_VALS),"name")  }</PROFILE>
	<ROLLCODE>{ obtieneToken(data($outputParameters1/ns1:RSP_ATTR_NAMES),data($outputParameters1/ns1:RSP_ATTR_VALS),"employeeID") }</ROLLCODE>
	<ROLLNAME></ROLLNAME>
	<USER_INFORMATION>
		<NAME>memberOf</NAME>
		<VALUE>{ obtieneToken(data($outputParameters1/ns1:RSP_ATTR_NAMES),data($outputParameters1/ns1:RSP_ATTR_VALS),"memberOf") }</VALUE>
	</USER_INFORMATION>
</ns0:loginResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:LoginUsuarioADOut($outputParameters1)