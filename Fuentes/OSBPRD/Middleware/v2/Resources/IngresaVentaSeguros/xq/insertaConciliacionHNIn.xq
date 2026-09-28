(:: pragma bea:global-element-parameter parameter="$ingresaVentaSeguros" element="ns1:ingresaVentaSeguros" location="../xsd/ingresaVentaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Terceros/insertaConciliacionVentaSeguros/xsd/insertaConciliacionVS_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertaConciliacionVS";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/insertaConciliacionHNIn/";

declare function xf:insertaConciliacionHNIn($ingresaVentaSeguros as element(ns1:ingresaVentaSeguros),
    $ventaOnline as xs:string,
    $estadoVenta as xs:string,
    $estadoTransaccion as xs:string,
    $EstadoReversion as xs:string,
    $idTransaccion as xs:string,
    $descripcionError as xs:string,
    $canal as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NOMBRECOMPLETO>{ data($ingresaVentaSeguros/INSURED/LEGAL_HOLDER_NAME) }</ns0:PV_NOMBRECOMPLETO>
            <ns0:PV_NUMEROIDENTIFICACION>{ data($ingresaVentaSeguros/INSURED/LEGAL_ID) }</ns0:PV_NUMEROIDENTIFICACION>
            <ns0:PV_FECHANACIMIENTO>{ data($ingresaVentaSeguros/INSURED/DATE_OF_BIRTH) }</ns0:PV_FECHANACIMIENTO>
            <ns0:PV_NUMEROCELULAR>{ data($ingresaVentaSeguros/INSURED/PHONE_INFO/PHONE_NUMBER_ITEM[1]/PHONE_NUMBER) }</ns0:PV_NUMEROCELULAR>
            <ns0:PV_CORREOELECTRONICO>{ data($ingresaVentaSeguros/INSURED/EMAIL_ADDRESS) }</ns0:PV_CORREOELECTRONICO>
            <ns0:PV_MEDIOPAGO>{ data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_METHOD) }</ns0:PV_MEDIOPAGO>
            {
            	for $PAYMENT_PRODUCT_NUMBER in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_PRODUCT_NUMBER
                return
            		if( $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_METHOD/text() = 'ACCT_DEBIT')then(
                    	<ns0:PV_CUENTABANCARIA>{ data($PAYMENT_PRODUCT_NUMBER) }</ns0:PV_CUENTABANCARIA>
            		)else(
            			<ns0:PV_CUENTABANCARIA></ns0:PV_CUENTABANCARIA>
         			)
         	}
         	{
            	for $PAYMENT_PRODUCT_NUMBER in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_PRODUCT_NUMBER
                return
            		if( $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_METHOD/text() = 'CREDIT_CARD')then(
                    	<ns0:PV_TARJETACREDITO>{ data($PAYMENT_PRODUCT_NUMBER) }</ns0:PV_TARJETACREDITO>
            		)else(
            			<ns0:PV_TARJETACREDITO></ns0:PV_TARJETACREDITO>
         			)
         	}
            <ns0:PV_MONEDA>{ data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_CURRENCY) }</ns0:PV_MONEDA>
            {
                for $PRODUCT_NUMBER_REF in $ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PRODUCT_NUMBER_REF
                return
                    <ns0:PV_TARJETADEBITOATM>{ data($PRODUCT_NUMBER_REF) }</ns0:PV_TARJETADEBITOATM>
            }
            {
                for $LOCATION in $ingresaVentaSeguros/CHANNEL_INFORMATION/LOCATION
                return
                    <ns0:PV_UBICACIONATM>{ data($LOCATION) }</ns0:PV_UBICACIONATM>
            }
            <ns0:PV_COBRO_ONLINE>{ $ventaOnline }</ns0:PV_COBRO_ONLINE>
            <ns0:PV_ESTADOVENTA>{ $estadoVenta }</ns0:PV_ESTADOVENTA>
            <ns0:PV_ESTADOTRANSACCION>{ $estadoTransaccion }</ns0:PV_ESTADOTRANSACCION>
            <ns0:PV_ESTADOREVERSION>{ $EstadoReversion }</ns0:PV_ESTADOREVERSION>
            <ns0:PV_CODIGOTRANSACCION>{ $idTransaccion }</ns0:PV_CODIGOTRANSACCION>
            <ns0:PV_DESCRIPCIONERROR>{ $descripcionError }</ns0:PV_DESCRIPCIONERROR>
            <ns0:PV_CANAL>{ $canal }</ns0:PV_CANAL>
            
        </ns0:InputParameters>
};

declare variable $ingresaVentaSeguros as element(ns1:ingresaVentaSeguros) external;
declare variable $ventaOnline as xs:string external;
declare variable $estadoVenta as xs:string external;
declare variable $estadoTransaccion as xs:string external;
declare variable $EstadoReversion as xs:string external;
declare variable $idTransaccion as xs:string external;
declare variable $descripcionError as xs:string external;
declare variable $canal as xs:string external;

xf:insertaConciliacionHNIn($ingresaVentaSeguros,
    $ventaOnline,
    $estadoVenta,
    $estadoTransaccion,
    $EstadoReversion,
    $idTransaccion,
    $descripcionError,
    $canal)