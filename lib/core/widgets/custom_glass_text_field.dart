// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../../../utilities/sizing/size_config.dart';

// class GlassTextField extends FormField<String> {
//   final TextEditingController controller;
//   final String hintText;

//   final bool isPassword;
//   final TextInputType? keyboardType;
//   final IconData? suffixIcon;
//   final String? prefixSvgAsset;
//   final IconData? prefixIcon;
//   final double? fieldHeight;
//   final ValueChanged<String>? onChanged;

//   final bool isRequired;
//   final String? requiredMessage;

//   final int? minLength;
//   final String? minLengthMessage;

//   final RegExp? pattern;
//   final String? patternMessage;

//   final TextEditingController? matchController;
//   final String? matchMessage;

//   final bool trimOnValidate;

//   final bool enabled;
//   final bool readOnly;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputAction? textInputAction;
//   final VoidCallback? onTap;

//   GlassTextField({
//     super.key,
//     this.suffixIcon,
//     required this.controller,
//     required this.hintText,
//     FormFieldValidator<String>? validator,
//     this.isPassword = false,
//     this.keyboardType,
//     this.prefixSvgAsset,
//     this.prefixIcon,
//     this.fieldHeight,
//     this.onChanged,

//     this.isRequired = false,
//     this.requiredMessage,
//     this.minLength,
//     this.minLengthMessage,
//     this.pattern,
//     this.patternMessage,
//     this.matchController,
//     this.matchMessage,
//     this.trimOnValidate = true,

//     this.enabled = true,
//     this.readOnly = false,
//     this.inputFormatters,
//     this.textInputAction,
//     this.onTap,
//   }) : super(
//     validator: validator ??
//             (value) {
//           final raw = value ?? '';
//           final v = trimOnValidate ? raw.trim() : raw;

//           if (isRequired && v.isEmpty) {
//             return requiredMessage ?? 'This field is required';
//           }

//           if (minLength != null && v.length < minLength!) {
//             return minLengthMessage ?? 'Minimum length is $minLength';
//           }

//           if (pattern != null && v.isNotEmpty && !pattern!.hasMatch(v)) {
//             return patternMessage ?? 'Invalid value';
//           }

//           if (matchController != null) {
//             final otherRaw = matchController!.text;
//             final other = trimOnValidate ? otherRaw.trim() : otherRaw;
//             if (v.isNotEmpty && v != other) {
//               return matchMessage ?? 'Values do not match';
//             }
//           }

//           return null;
//         },
//     initialValue: controller.text,
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     builder: (FormFieldState<String> state) {
//       final hasError = state.hasError;

//       Widget? prefix;
//       if (prefixSvgAsset != null) {
//         prefix = SvgPicture.asset(
//           prefixSvgAsset,
//           height: SizeConfig.height(18),
//           width: SizeConfig.height(18),
//           colorFilter: ColorFilter.mode(
//             Colors.white.withValues(alpha: 0.70),
//             BlendMode.srcIn,
//           ),
//         );
//       } else if (prefixIcon != null) {
//         prefix = Icon(
//           prefixIcon,
//           size: SizeConfig.height(18),
//           color: Colors.white.withValues(alpha: 0.70),
//         );
//       }

//       return _GlassTextFieldBody(
//         controller: controller,
//         hintText: hintText,
//         keyboardType: keyboardType,
//         suffixIcon: suffixIcon,
//         isPassword: isPassword,
//         prefix: prefix,
//         fieldHeight: fieldHeight,
//         hasError: hasError,
//         errorText: state.errorText,
//         enabled: enabled,
//         readOnly: readOnly,
//         inputFormatters: inputFormatters,
//         textInputAction: textInputAction,
//         onTap: onTap,
//         onChanged: (v) {
//           state.didChange(v);
//           onChanged?.call(v);
//         },
//       );
//     },
//   );
// }

// class _GlassTextFieldBody extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType? keyboardType;
//   final IconData? suffixIcon;
//   final bool isPassword;
//   final Widget? prefix;
//   final double? fieldHeight;
//   final bool hasError;
//   final String? errorText;
//   final ValueChanged<String> onChanged;

//   final bool enabled;
//   final bool readOnly;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputAction? textInputAction;
//   final VoidCallback? onTap;

//   const _GlassTextFieldBody({
//     required this.controller,
//     required this.hintText,
//     required this.keyboardType,
//     required this.isPassword,
//     required this.prefix,
//     required this.fieldHeight,
//     required this.hasError,
//     required this.errorText,
//     required this.suffixIcon,
//     required this.onChanged,
//     required this.enabled,
//     required this.readOnly,
//     required this.inputFormatters,
//     required this.textInputAction,
//     required this.onTap,
//   });

//   @override
//   State<_GlassTextFieldBody> createState() => _GlassTextFieldBodyState();
// }

// class _GlassTextFieldBodyState extends State<_GlassTextFieldBody> {
//   bool _obscure = true;

//   @override
//   void initState() {
//     super.initState();
//     _obscure = widget.isPassword;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final suffix = widget.isPassword
//         ? GestureDetector(
//       onTap: () => setState(() => _obscure = !_obscure),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(14)),
//         child: Icon(
//           _obscure ? Icons.visibility_off : Icons.visibility,
//           size: SizeConfig.height(18),
//           color: widget.hasError
//               ? const Color(0xffEF4444)
//               : Colors.grey.withValues(alpha: 0.70),
//         ),
//       ),
//     )
//         : (widget.suffixIcon == null
//         ? null
//         : Padding(
//       padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(14)),
//       child: Icon(
//         widget.suffixIcon!,
//         size: SizeConfig.height(18),
//         color: widget.hasError
//             ? const Color(0xffEF4444)
//             : Colors.grey.withValues(alpha: 0.70),
//       ),
//     ));

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: widget.fieldHeight ?? SizeConfig.height(54),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(SizeConfig.height(14)),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 widget.hasError
//                     ? const Color(0x22EF4444)
//                     : Colors.white.withValues(alpha: 0.09),
//                 widget.hasError
//                     ? const Color(0x11EF4444)
//                     : Colors.white.withValues(alpha: 0.05),
//               ],
//             ),
//             border: Border.all(
//               color: widget.hasError
//                   ? const Color(0xffEF4444)
//                   : Colors.white.withValues(alpha: 0.14),
//               width: 1,
//             ),
//           ),
//           child: TextField(
//             controller: widget.controller,
//             keyboardType: widget.keyboardType,
//             obscureText: widget.isPassword ? _obscure : false,
//             onChanged: widget.onChanged,
//             enabled: widget.enabled,
//             readOnly: widget.readOnly,
//             inputFormatters: widget.inputFormatters,
//             textInputAction: widget.textInputAction,
//             onTap: widget.onTap,
//             style: GoogleFonts.montserrat(
//               color: Colors.white,
//               fontSize: SizeConfig.height(14),
//               fontWeight: FontWeight.w600,
//             ),
//             cursorColor: Colors.white.withValues(alpha: 0.85),
//             decoration: InputDecoration(
//               hintText: widget.hintText,
//               hintStyle: GoogleFonts.montserrat(
//                 color: Colors.white.withValues(alpha: 0.45),
//                 fontSize: SizeConfig.height(13),
//                 fontWeight: FontWeight.w500,
//               ),
//               prefixIcon:
//               widget.prefix == null ? null : SizedBox(child: widget.prefix),
//               suffixIcon: suffix == null ? null : SizedBox(child: suffix),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(SizeConfig.height(14)),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(SizeConfig.height(14)),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(SizeConfig.height(14)),
//                 borderSide: BorderSide.none,
//               ),
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: SizeConfig.width(16),
//                 vertical: SizeConfig.height(16),
//               ),
//             ),
//           ),
//         ),
//         if (widget.hasError && (widget.errorText ?? '').isNotEmpty) ...[
//           SizedBox(height: SizeConfig.height(6)),
//           Text(
//             widget.errorText!,
//             style: TextStyle(
//               color: Theme.of(context)
//                   .colorScheme
//                   .error
//                   .withValues(alpha: 0.95),
//               fontSize: SizeConfig.height(12),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }
