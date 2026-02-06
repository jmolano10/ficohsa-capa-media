xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaDatosClienteIN" element="ns0:validaDatosCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaDatosClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/validaDatosClienteNIOUT/";

declare function RiesgoCobis($Nivel as xs:string) as xs:string {
	if ($Nivel = 'BJ') then (
		'LOW'
    ) else if( ($Nivel = 'AL') or ($Nivel = 'AC'))  then (
    	'HIGH'
     ) else if( ($Nivel = 'ME'))  then (
    	'MEDIUM'
    ) else (
    	'ERROR'
    )
};



declare function xf:validaDatosClienteNIOUT(
    $isCobis as xs:string,
    $isFiscan as xs:string,
    $isCobisValue as xs:string,
    $isFiscanValue as xs:string,
    $LegalID as xs:string,
    $CostumerName as xs:string
    
    )
    as element(ns0:validaDatosClienteResponse) {
        <ns0:validaDatosClienteResponse>
            <LEGAL_ID>{ $LegalID }</LEGAL_ID>
            <CUSTOMER_NAME>{ $CostumerName }</CUSTOMER_NAME>
            {
             if ($isCobis ='YES' or $isFiscan ='YES') then(
            <ASSOCIATIONS_LIST>
                    {
                   if ($isCobis ='YES') then (
                <ASSOCIATION>
                    <NAME>COBIS</NAME>
                    <STATUS>{RiesgoCobis($isCobisValue) }</STATUS>
                </ASSOCIATION>
                     )
                    else()
                   }
                    {
                   if ($isFiscan ='YES') then (
                <ASSOCIATION>
                    <NAME>FISCAN</NAME>
                    <STATUS>{ $isFiscanValue }</STATUS>
                </ASSOCIATION>
                     )
                    else()
                   }
            </ASSOCIATIONS_LIST>
            )
            else()
            }
        </ns0:validaDatosClienteResponse>
};

declare variable $validaDatosClienteIN as element(ns0:validaDatosCliente) external;
declare variable $isCobis as xs:string external;
declare variable $isFiscan as xs:string external;
declare variable $isCobisValue as xs:string external;
declare variable $isFiscanValue as xs:string external;
declare variable $LegalID as xs:string external;
declare variable $CostumerName as xs:string external;

xf:validaDatosClienteNIOUT(
    $isCobis,
    $isFiscan,
    $isCobisValue,
    $isFiscanValue,
    $LegalID,
    $CostumerName
    )