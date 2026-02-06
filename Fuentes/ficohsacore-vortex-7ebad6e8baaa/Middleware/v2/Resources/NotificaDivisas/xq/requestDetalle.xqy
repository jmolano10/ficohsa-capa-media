xquery version "2004-draft";
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaDivisasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/requestDetalle/";

declare function xf:requestDetalle($DETAILS as element(),
    $userName as xs:string,
    $password as xs:string,
    $entity as xs:string)
    as element(*) {
    	<formularios>
    	{
    		for $DETAIL in $DETAILS/DETAIL
    		return
    		<formularios_row>
    			<fecha>{data($DETAIL/DATE)}</fecha>
    			<institucion>{data($DETAIL/INSTITUTION_CODE)}</institucion>
    			<id_documento>{data($DETAIL/DOCUMENT_ID)}</id_documento>
    			<tipo_docto>{data($DETAIL/FORM_TYPE)}</tipo_docto>
    			<nit>{data($DETAIL/NIT)}</nit>
    			<nombre>{data($DETAIL/NAME)}</nombre>
    			<direccion>{data($DETAIL/ADDRESS)}</direccion>
    			<telefono>{data($DETAIL/PHONE_NUMBER)}</telefono>
    			<correo>{data($DETAIL/EMAIL)}</correo>
    			<tipo_entidad>{data($DETAIL/DOCUMENT_TYPE)}</tipo_entidad>
    			<desc_entidad>{data($DETAIL/DOCUMENT_DESCRIPTION)}</desc_entidad>
    			<clase_moneda>{data($DETAIL/CURRENCY_CLASS)}</clase_moneda>
    			<equiv_dolar>{data($DETAIL/USD_EQUIVALENT)}</equiv_dolar>
    			<equiv_quetzal>{data($DETAIL/GTQ_EQUIVALENT)}</equiv_quetzal>
    			<monto_moneda_ext>{data($DETAIL/FOREIGN_CURRENCY_AMOUNT)}</monto_moneda_ext>
    			<pais>{data($DETAIL/SOURCE_COUNTRY)}</pais>
    			<tipo_cambio>{data($DETAIL/EXCHANGE_RATE)}</tipo_cambio>
    			<nombre_ben>{data($DETAIL/BENEFICIARY_NAME)}</nombre_ben>
    			<medio_pago>{data($DETAIL/PAYMENT_METHOD)}</medio_pago>
    			<desc_medio_pago>{data($DETAIL/PAYMENT_METHOD_DESCRIPTION)}</desc_medio_pago>
    			<departamento>{data($DETAIL/DEPARTMENT)}</departamento>
    			<municipio>{data($DETAIL/CITY)}</municipio>
    			<numero_spid>{data($DETAIL/SPID)}</numero_spid>
    			<balanza>{data($DETAIL/BALANCE)}</balanza>
    			<desc_balanza>{data($DETAIL/BALANCE_DESCRIPTION)}</desc_balanza>
    			<pais_exportado>{data($DETAIL/DESTINATION_COUNTRY)}</pais_exportado>
    			<producto>{data($DETAIL/PRODUCT)}</producto>
    			<producto_desc>{data($DETAIL/PRODUCT_DESCRIPTION)}</producto_desc>
    			<origen_divisas>{data($DETAIL/CURRENCY_ORIGIN)}</origen_divisas>
    			<codigo_remesadora>{data($DETAIL/REMITTER_CODE)}</codigo_remesadora>
    			<nombre_remesadora>{data($DETAIL/REMITTER_NAME)}</nombre_remesadora>
    			<codigo_parentesco>{data($DETAIL/RELATIONSHIP_CODE)}</codigo_parentesco>
    			<codigo_destino_remesas>{data($DETAIL/DESTINATION_CODE)}</codigo_destino_remesas>
    			<desc_operacion>{data($DETAIL/OPERATION_DESCRIPTION)}</desc_operacion>
    			<tipo_operacion>{data($DETAIL/OPERATION_TYPE)}</tipo_operacion>
     		</formularios_row>
    	}
    	</formularios>
       
};

declare variable $DETAILS as element() external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $entity as xs:string external;

xf:requestDetalle($DETAILS,
    $userName,
    $password,
    $entity)