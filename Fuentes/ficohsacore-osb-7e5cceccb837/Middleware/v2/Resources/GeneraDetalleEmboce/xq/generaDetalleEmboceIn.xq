(:: pragma  parameter="$cardInformation" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:generaDetalleEmboceRequest" location="../../../BusinessServices/Switch/generaDetalleEmboce/wsdl/debitCardOperationServices.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/generaDetalleEmboceIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/schema/debitCardOperationTypes";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare function getKey ($userInstruction as xs:string) as xs:string {
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($userInstruction)))
  		return
		   $data/con:password/text()
};

declare function xf:generaDetalleEmboceIn($cardInformation as element(*),
	$pinBlockUser as xs:string,
	$pvvUser as xs:string,
	$cvvUser as xs:string,
	$cvv2User as xs:string,
	$icvvUser as xs:string,
	$countryCode as xs:string)
    as element(ns0:generaDetalleEmboceRequest) {
        <ns0:generaDetalleEmboceRequest>
			<cardDetails>
				{
					let $pvkiPinBlock := fn:substring($pinBlockUser, fn:string-length($pinBlockUser), 1)
					let $pvkiPVV := fn:substring($pvvUser, fn:string-length($pvvUser), 1)
					let $pvkiCVV := fn:substring($cvvUser, fn:string-length($cvvUser), 1)
					let $pvkiCVV2 := fn:substring($cvv2User, fn:string-length($cvv2User), 1)
					let $pvkiICVV := fn:substring($icvvUser, fn:string-length($icvvUser), 1)
					for $CARD in $cardInformation/CARD_DETAILS/CARD_ITEM
					return(
						<cardItem>
							<cardNumber>{ fn:string($CARD/CARD_NUMBER/text()) }</cardNumber>
							<bin>{ fn:string($CARD/BIN/text()) }</bin>
							<nameOnCard>{ fn:string($CARD/NAME_ON_CARD/text()) }</nameOnCard>
							<expirationDate>{ fn-bea:date-to-string-with-format("yyMM",xs:date($CARD/EXPIRATION_DATE/text())) }</expirationDate>
							<serviceCode>{ fn:string($CARD/SERVICE_CODE/text()) }</serviceCode>
							<cryptographicKeyPinBlock>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLAPINBLOCK',$pvkiPinBlock)), $pinBlockUser) }</cryptographicKeyPinBlock>
							<instructionDetails>
								{
									for $INSTRUCTION_ITEM in $CARD/INSTRUCTION_DETAILS/GENERATION_ITEM
									return
										if(fn:string($INSTRUCTION_ITEM/GENERATE_INSTRUCTION/text()) = 'PVV') then(
											<generateItem>
												<pvki>{ $pvkiPVV }</pvki>
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLAPVV',$pvkiPVV)), $pvvUser) }</cryptographicKey>
												<generateInstruction>PVV</generateInstruction>
											</generateItem>		
										)else if(fn:string($INSTRUCTION_ITEM/GENERATE_INSTRUCTION/text()) = 'CVV2') then(
											<generateItem>		
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLACVV', $pvkiCVV)), $cvvUser) }</cryptographicKey>
												<generateInstruction>CVV</generateInstruction>
											</generateItem>,
											<generateItem>
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode, 'ATALLACVV2', $pvkiCVV2)), $cvv2User) }</cryptographicKey>
												<generateInstruction>CVV2</generateInstruction>
											</generateItem>		
										)else if(fn:string($INSTRUCTION_ITEM/GENERATE_INSTRUCTION/text()) = 'ICVV') then(
											<generateItem>		
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLAICVV', $pvkiICVV)), $icvvUser) }</cryptographicKey>
												<generateInstruction>ICVV</generateInstruction>
											</generateItem>
										)else if(fn:string($INSTRUCTION_ITEM/GENERATE_INSTRUCTION/text()) = 'ALL') then(
											<generateItem>
												<pvki>{ $pvkiPVV }</pvki>
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLAPVV', $pvkiPVV)), $pvvUser) }</cryptographicKey>
												<generateInstruction>PVV</generateInstruction>
											</generateItem>,
											<generateItem>		
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLACVV', $pvkiCVV)), $cvvUser) }</cryptographicKey>
												<generateInstruction>CVV</generateInstruction>
											</generateItem>,
											<generateItem>
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode,'ATALLACVV2', $pvkiCVV2)), $cvv2User) }</cryptographicKey>
												<generateInstruction>CVV2</generateInstruction>
											</generateItem>,				
											<generateItem>		
												<cryptographicKey>{ fn-bea:fail-over(getKey(fn:concat($countryCode, 'ATALLAICVV', $pvkiICVV)), $icvvUser) }</cryptographicKey>
												<generateInstruction>ICVV</generateInstruction>
											</generateItem>
										)else()
								}
							</instructionDetails>
						</cardItem>
					)
				}
			</cardDetails>
        </ns0:generaDetalleEmboceRequest>
};

declare variable $cardInformation as element(*) external;
declare variable $pinBlockUser as xs:string external;
declare variable $pvvUser as xs:string external;
declare variable $cvvUser as xs:string external;
declare variable $cvv2User as xs:string external;
declare variable $icvvUser as xs:string external;
declare variable $countryCode as xs:string external;

xf:generaDetalleEmboceIn($cardInformation,
	$pinBlockUser,
	$pvvUser,
	$cvvUser,
	$cvv2User,
	$icvvUser,
	$countryCode)