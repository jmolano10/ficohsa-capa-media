xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPlanesCredito" element="ns0:consultaPlanesCredito" location="../../ConsultaPlanesCredito/xsd/consultaPlanesCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataPA/conDatosPlanes/xsd/conDatosPlanes_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataPA/xq/conDatosPlanesPAIn/";

declare function xf:conDatosPlanesPAIn($consultaPlanesCredito as element(ns0:consultaPlanesCredito),
    $CodigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $CodigoPais }</ns1:Pais>
            {
                for $ORG in $consultaPlanesCredito/ORG
                return
                    if(data($ORG) != '') then(
				 			 <ns1:Org>{ data($ORG) }</ns1:Org>
				 	)else()
            }
            <ns1:NumCuenta>{ fn-bea:pad-left(data($consultaPlanesCredito/ACCOUNT_NUMBER), 19, '0') }</ns1:NumCuenta>
        </ns1:InputParameters>
};

declare variable $consultaPlanesCredito as element(ns0:consultaPlanesCredito) external;
declare variable $CodigoPais as xs:string external;

xf:conDatosPlanesPAIn($consultaPlanesCredito,
    $CodigoPais)