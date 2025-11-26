(:: pragma bea:global-element-parameter parameter="$registraParametrizacion" element="ns0:registraParametrizacion" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/RegistraParametrizacion/xsd/registraParametrizacion_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraParametrizacion";
declare namespace xf = "http://tempuri.org/MWCaja/registraParametrizacionIn/";

declare function xf:registraParametrizacionIn($registraParametrizacion as element(ns0:registraParametrizacion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_TIPO_FINANCIERA>2</ns1:PN_TIPO_FINANCIERA>
            {
                for $NAME in $registraParametrizacion/NAME
                return
                    <ns1:PV_NOMBRE>{ data($NAME) }</ns1:PV_NOMBRE>
            }
            {
                for $ID_CEPROBAN in $registraParametrizacion/ID_CEPROBAN
                return
                    <ns1:PN_CODIGO_BANCARIO>{ data($ID_CEPROBAN) }</ns1:PN_CODIGO_BANCARIO>
            }
            {
                let $result :=
                    for $PRODUCT_TYPE in $registraParametrizacion/PRODUCT_TYPE,
                        $MAX_LENGTH in $PRODUCT_TYPE/MAX_LENGTH
                    return
                    	if(fn:upper-case($PRODUCT_TYPE/TYPE) = 'SAVINGS') then
                    	$MAX_LENGTH                    
                        else()
                return
                	if($result[1] != '') then
                	<ns0:PN_MAX_NRO_CUENTA>{ data($result[1]) }</ns0:PN_MAX_NRO_CUENTA> 
                	else(
                	<ns0:PN_MAX_NRO_CUENTA>{data($registraParametrizacion/PRODUCT_TYPE[1]/MAX_LENGTH)}</ns0:PN_MAX_NRO_CUENTA>
                	)
                                     
            }
            {
                let $result :=
                    for $PRODUCT_TYPE in $registraParametrizacion/PRODUCT_TYPE,
                        $MIN_LENGTH in $PRODUCT_TYPE/MIN_LENGTH
                    return
                    	if(fn:upper-case($PRODUCT_TYPE/TYPE) = 'SAVINGS') then
                    	$MIN_LENGTH                    
                        else()
                return
                	if($result[1] != '') then
                	<ns0:PN_MIN_LARGO_CTA_ACH>{ data($result[1]) }</ns0:PN_MIN_LARGO_CTA_ACH> 
                	else(
                	<ns0:PN_MIN_LARGO_CTA_ACH>{data($registraParametrizacion/PRODUCT_TYPE[1]/MIN_LENGTH)}</ns0:PN_MIN_LARGO_CTA_ACH>
                	)
                                     
            }              
        </ns1:InputParameters>
};

declare variable $registraParametrizacion as element(ns0:registraParametrizacion) external;

xf:registraParametrizacionIn($registraParametrizacion)
