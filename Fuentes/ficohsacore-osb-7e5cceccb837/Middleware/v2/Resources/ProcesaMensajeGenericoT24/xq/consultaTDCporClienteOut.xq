(:: pragma bea:global-element-parameter parameter="$informacionTarjetaResponse1" element="ns1:InformacionTarjetaResponse" location="../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaTDCporClienteOut6/";

declare function xf:consultaTDCporClienteOut6($TransaccionID as xs:string,
    $SeccionID as xs:string,
    $SuccessIndicator as xs:string,
    $informacionTarjetaResponse1 as element(ns1:InformacionTarjetaResponse))
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
          {
          if  (fn:string( $SuccessIndicator) = "00") then
        	(
            <TRANSACTION_ID>{ $TransaccionID }</TRANSACTION_ID>,
            <SESSION_ID>{ $SeccionID }</SESSION_ID>,
            <MESSAGE>{ 
					concat($informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:NumeroCuenta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:NombreTarjetaTitular/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:NombreTarjetaHabiente/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:TipoTarjeta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:CodigoClienteCuenta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:IdentificacionClienteCuenta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:IdentificacionCLienteTarjeta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:Producto/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:GrupoAfinidad/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:EstadoCuenta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:EstadoTarjeta/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:FechaVencimiento/text(),
					'@VM',$informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:CategoriaTarjeta/text(),
					'@SM@FMSUCCESS')
            	     } </MESSAGE>
             )
             else ( )
           }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $TransaccionID as xs:string external;
declare variable $SeccionID as xs:string external;
declare variable $SuccessIndicator as xs:string external;
declare variable $informacionTarjetaResponse1 as element(ns1:InformacionTarjetaResponse) external;

xf:consultaTDCporClienteOut6($TransaccionID,
    $SeccionID,
    $SuccessIndicator,
    $informacionTarjetaResponse1)
