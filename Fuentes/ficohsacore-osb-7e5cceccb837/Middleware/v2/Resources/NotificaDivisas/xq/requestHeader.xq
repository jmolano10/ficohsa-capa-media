xquery version "1.0" encoding "Cp1252";
(:: pragma bea:local-element-parameter parameter="$HEADER" type="ns0:notificaDivisas/HEADER" location="../xsd/notificaDivisasTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/requestHeader/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaDivisasTypes";

declare function xf:requestHeader($HEADER as element())
    as element(*) {
        <encabezado>
    	{
    		for $HEADER_ROW in $HEADER/HEADER_ROW
    		return
    		<encabezado_row>
    			<institucion>{data($HEADER_ROW/INSTITUTION_CODE)}</institucion>
    			<fecha>{data($HEADER_ROW/DATE)}</fecha>
    			<ing_compra_cant>{data($HEADER_ROW/BUY_OPERATION_COUNT)}</ing_compra_cant>
    			<ing_compra_monto>{data($HEADER_ROW/BUY_OPERATION_AMOUNT)}</ing_compra_monto>
    			<ing_cta_ajena_cant>{data($HEADER_ROW/OTHER_ACCOUNT_OPERATION_INCOME)}</ing_cta_ajena_cant>
    			<ing_cta_ajena_monto>{data($HEADER_ROW/OTHER_ACCOUNT_AMOUNT_INCOME)}</ing_cta_ajena_monto>
    			<ing_propios_cant>{data($HEADER_ROW/OWN_INSTITUTION_OPERATION_INCOME)}</ing_propios_cant>
    			<ing_propios_monto>{data($HEADER_ROW/OWN_INSTITUTION_AMOUNT_INCOME)}</ing_propios_monto>
    			<ing_total>{data($HEADER_ROW/TOTAL_AMOUNT_INCOME)}</ing_total>
    			<egr_compra_cant>{data($HEADER_ROW/SALE_OPERATION_COUNT)}</egr_compra_cant>
    			<egr_compra_monto>{data($HEADER_ROW/SALE_OPERATION_AMOUNT)}</egr_compra_monto>
    			<egr_cta_ajena_cant>{data($HEADER_ROW/OTHER_ACCOUNT_OPERATION_EXPENSES)}</egr_cta_ajena_cant>
    			<egr_cta_ajena_monto>{data($HEADER_ROW/OTHER_ACCOUNT_AMOUNT_EXPENSES)}</egr_cta_ajena_monto>
    			<egr_propios_cant>{data($HEADER_ROW/OWN_INSTITUTION_OPERATION_EXPENSES)}</egr_propios_cant>
    			<egr_propios_monto>{data($HEADER_ROW/OWN_INSTITUTION_AMOUNT_EXPENSES)}</egr_propios_monto>
    			<egr_total>{data($HEADER_ROW/TOTAL_AMOUNT_EXPENSES)}</egr_total>
    			<nombre_responsable>{data($HEADER_ROW/OFFICIAL_NAME)}</nombre_responsable>
    		</encabezado_row>
    	}
    	</encabezado>
};

declare variable $HEADER as element() external;

xf:requestHeader($HEADER)
