declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/tipoFlujoConsulta/";

declare function xf:tipoFlujoConsulta($string1 as xs:string)
    as xs:string {
        getTipoFlujo($string1)
};

declare function getTipoFlujo($string1 as xs:string)
	as xs:string {
		if($string1 = 'DEPOSITO') then(
			'NUEVO_FLUJO'
		)else if($string1 = 'DEPOSITO_REFERENCIADO') then(
			'NUEVO_FLUJO'
		)else if($string1 = 'PAGO_TC') then(
			'NUEVO_FLUJO'
		)else if($string1 = 'PAGO_EEH') then(
			'TRANSACCION_GENERICA'
		)else ('VIEJO_FLUJO')
};

declare variable $string1 as xs:string external;

xf:tipoFlujoConsulta($string1)