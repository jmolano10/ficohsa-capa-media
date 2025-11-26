(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/consultaInfoUsuarioAD/xsd/consultarInfoUsuarioAD_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUsuarioLdapResponse" location="../xsd/consultaUsuarioLdapTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioLdapTypes/v2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarInfoUsuarioAD";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuarioLdap/xq/consultaUsuarioLdapOut/";

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

declare function obtienePais($listaNombres as xs:string, $listaCodigos as xs:string, $nombre as xs:string) as xs:string {
    let $LISTA_NOMBRES := fn:tokenize($listaNombres, "\|\|")
    let $LISTA_CODIGOS := fn:tokenize($listaCodigos, "\|\|")
    let $codigoPais := (
    for $i in (1 to count($LISTA_NOMBRES))
    return
        if (fn:contains(upper-case($nombre), upper-case($LISTA_NOMBRES[$i]))) then 
        (
            $LISTA_CODIGOS[$i]
        ) 
        else ()
        )
        return
        if (fn:empty($codigoPais)) then 
        (
            ""
        ) else 
        (
            $codigoPais[1]
        )
};

declare function xf:consultaUsuarioLdapOut($outputParameters1 as element(ns0:OutputParameters))
as element(ns1:consultaUsuarioLdapResponse) 
{
    if (data($outputParameters1/ns0:COD_ERROR) = "SUCCESS") then 
    (
        <ns1:consultaUsuarioLdapResponse>
            <ns1:consultaUsuarioLdapResponseType>
                <ns1:consultaUsuarioLdapResponseRecordType>
                {
                    <USER_NAME>{ obtieneToken(data($outputParameters1/ns0:RSP_ATTR_NAMES),data($outputParameters1/ns0:RSP_ATTR_VALS),"name") }</USER_NAME>,
                    <EMAIL>{ obtieneToken(data($outputParameters1/ns0:RSP_ATTR_NAMES),data($outputParameters1/ns0:RSP_ATTR_VALS),"mail") }</EMAIL>,
                    <COUNTRY>{ obtieneToken(data($outputParameters1/ns0:RSP_ATTR_NAMES),data($outputParameters1/ns0:RSP_ATTR_VALS),"c") }</COUNTRY>,
                    <BRANCH_NAME>{ obtieneToken(data($outputParameters1/ns0:RSP_ATTR_NAMES),data($outputParameters1/ns0:RSP_ATTR_VALS),"physicalDeliveryOfficeName") }</BRANCH_NAME>
                }	       
                </ns1:consultaUsuarioLdapResponseRecordType>
            </ns1:consultaUsuarioLdapResponseType>
        </ns1:consultaUsuarioLdapResponse>
    ) 
    else 
        (<ns1:consultaUsuarioLdapResponse/>)
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaUsuarioLdapOut($outputParameters1)