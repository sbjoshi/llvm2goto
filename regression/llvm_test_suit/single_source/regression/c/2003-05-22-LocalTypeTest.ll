; ModuleID = '2003-05-22-LocalTypeTest.c'
source_filename = "2003-05-22-LocalTypeTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.sometimes.1 = type { i16, i16, i16, i16 }
%struct.sometimes = type { i32, i32 }
%struct.sometimes.0 = type { i8 }

@Y = common global %struct.sometimes.1 zeroinitializer, align 2, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !17 {
entry:
  %retval = alloca i32, align 4
  %X = alloca i32, align 4
  %S = alloca %struct.sometimes, align 4
  %S3 = alloca %struct.sometimes.0, align 1
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %X, metadata !21, metadata !22), !dbg !23
  call void @llvm.dbg.declare(metadata %struct.sometimes* %S, metadata !24, metadata !22), !dbg !30
  %X1 = getelementptr inbounds %struct.sometimes, %struct.sometimes* %S, i32 0, i32 0, !dbg !31
  store i32 1, i32* %X1, align 4, !dbg !32
  %X2 = getelementptr inbounds %struct.sometimes, %struct.sometimes* %S, i32 0, i32 0, !dbg !33
  %0 = load i32, i32* %X2, align 4, !dbg !33
  store i32 %0, i32* %X, align 4, !dbg !34
  call void @llvm.dbg.declare(metadata %struct.sometimes.0* %S3, metadata !35, metadata !22), !dbg !41
  %X4 = getelementptr inbounds %struct.sometimes.0, %struct.sometimes.0* %S3, i32 0, i32 0, !dbg !42
  store i8 -1, i8* %X4, align 1, !dbg !43
  %X5 = getelementptr inbounds %struct.sometimes.0, %struct.sometimes.0* %S3, i32 0, i32 0, !dbg !44
  %1 = load i8, i8* %X5, align 1, !dbg !44
  %conv = sext i8 %1 to i32, !dbg !45
  %2 = load i32, i32* %X, align 4, !dbg !46
  %add = add nsw i32 %2, %conv, !dbg !46
  store i32 %add, i32* %X, align 4, !dbg !46
  %3 = load i16, i16* getelementptr inbounds (%struct.sometimes.1, %struct.sometimes.1* @Y, i32 0, i32 0), align 2, !dbg !47
  %conv6 = sext i16 %3 to i32, !dbg !48
  %4 = load i32, i32* %X, align 4, !dbg !49
  %add7 = add nsw i32 %4, %conv6, !dbg !49
  store i32 %add7, i32* %X, align 4, !dbg !49
  %5 = load i32, i32* %X, align 4, !dbg !50
  %cmp = icmp eq i32 %5, 0, !dbg !51
  %conv8 = zext i1 %cmp to i32, !dbg !51
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !52
  %6 = load i32, i32* %X, align 4, !dbg !53
  ret i32 %6, !dbg !54
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "Y", scope: !2, file: !3, line: 6, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "2003-05-22-LocalTypeTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sometimes", file: !3, line: 3, size: 64, elements: !7)
!7 = !{!8, !10, !11, !12}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !6, file: !3, line: 4, baseType: !9, size: 16)
!9 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "bit", scope: !6, file: !3, line: 4, baseType: !9, size: 16, offset: 16)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "live_length", scope: !6, file: !3, line: 5, baseType: !9, size: 16, offset: 32)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "calls_crossed", scope: !6, file: !3, line: 5, baseType: !9, size: 16, offset: 48)
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!17 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 8, type: !18, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !2, variables: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{!20}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocalVariable(name: "X", scope: !17, file: !3, line: 9, type: !20)
!22 = !DIExpression()
!23 = !DILocation(line: 9, column: 7, scope: !17)
!24 = !DILocalVariable(name: "S", scope: !25, file: !3, line: 11, type: !26)
!25 = distinct !DILexicalBlock(scope: !17, file: !3, line: 10, column: 3)
!26 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sometimes", scope: !17, file: !3, line: 11, size: 64, elements: !27)
!27 = !{!28, !29}
!28 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !26, file: !3, line: 11, baseType: !20, size: 32)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "Y", scope: !26, file: !3, line: 11, baseType: !20, size: 32, offset: 32)
!30 = !DILocation(line: 11, column: 36, scope: !25)
!31 = !DILocation(line: 12, column: 7, scope: !25)
!32 = !DILocation(line: 12, column: 9, scope: !25)
!33 = !DILocation(line: 13, column: 11, scope: !25)
!34 = !DILocation(line: 13, column: 7, scope: !25)
!35 = !DILocalVariable(name: "S", scope: !36, file: !3, line: 16, type: !37)
!36 = distinct !DILexicalBlock(scope: !17, file: !3, line: 15, column: 3)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sometimes", scope: !17, file: !3, line: 16, size: 8, elements: !38)
!38 = !{!39}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !37, file: !3, line: 16, baseType: !40, size: 8)
!40 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!41 = !DILocation(line: 16, column: 41, scope: !36)
!42 = !DILocation(line: 17, column: 7, scope: !36)
!43 = !DILocation(line: 17, column: 9, scope: !36)
!44 = !DILocation(line: 18, column: 12, scope: !36)
!45 = !DILocation(line: 18, column: 10, scope: !36)
!46 = !DILocation(line: 18, column: 7, scope: !36)
!47 = !DILocation(line: 20, column: 10, scope: !17)
!48 = !DILocation(line: 20, column: 8, scope: !17)
!49 = !DILocation(line: 20, column: 5, scope: !17)
!50 = !DILocation(line: 23, column: 10, scope: !17)
!51 = !DILocation(line: 23, column: 12, scope: !17)
!52 = !DILocation(line: 23, column: 3, scope: !17)
!53 = !DILocation(line: 24, column: 10, scope: !17)
!54 = !DILocation(line: 24, column: 3, scope: !17)
