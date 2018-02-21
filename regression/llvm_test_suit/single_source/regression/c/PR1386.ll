; ModuleID = 'PR1386.c'
source_filename = "PR1386.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.X = type { i128 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !14 {
entry:
  %retval = alloca i32, align 4
  %x = alloca %struct.X, align 1
  %bad_bits = alloca i64, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.X* %x, metadata !18, metadata !25), !dbg !26
  call void @llvm.dbg.declare(metadata i64* %bad_bits, metadata !27, metadata !25), !dbg !28
  %0 = bitcast %struct.X* %x to i128*, !dbg !29
  %bf.load = load i128, i128* %0, align 1, !dbg !30
  %bf.clear = and i128 %bf.load, -16, !dbg !30
  %bf.set = or i128 %bf.clear, 15, !dbg !30
  store i128 %bf.set, i128* %0, align 1, !dbg !30
  %1 = bitcast %struct.X* %x to i128*, !dbg !31
  %bf.load1 = load i128, i128* %1, align 1, !dbg !32
  %bf.clear2 = and i128 %bf.load1, -295147905179352825841, !dbg !32
  %bf.set3 = or i128 %bf.clear2, 295147905179352825840, !dbg !32
  store i128 %bf.set3, i128* %1, align 1, !dbg !32
  %2 = bitcast %struct.X* %x to i128*, !dbg !33
  %bf.load4 = load i128, i128* %2, align 1, !dbg !34
  %bf.clear5 = and i128 %bf.load4, 295147905179352825855, !dbg !34
  %bf.set6 = or i128 %bf.clear5, -295147905179352825856, !dbg !34
  store i128 %bf.set6, i128* %2, align 1, !dbg !34
  %3 = bitcast %struct.X* %x to i64*, !dbg !35
  %add.ptr = getelementptr inbounds i64, i64* %3, i64 1, !dbg !36
  %4 = load i64, i64* %add.ptr, align 8, !dbg !37
  %xor = xor i64 -1, %4, !dbg !38
  store i64 %xor, i64* %bad_bits, align 8, !dbg !39
  %5 = load i64, i64* %bad_bits, align 8, !dbg !40
  %cmp = icmp eq i64 %5, 0, !dbg !41
  %conv = zext i1 %cmp to i32, !dbg !41
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !42
  %6 = load i64, i64* %bad_bits, align 8, !dbg !43
  %cmp7 = icmp ne i64 %6, 0, !dbg !44
  %conv8 = zext i1 %cmp7 to i32, !dbg !44
  ret i32 %conv8, !dbg !45
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "PR1386.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!2 = !{}
!3 = !{!4, !9}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !5, line: 27, baseType: !6)
!5 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!6 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !7, line: 44, baseType: !8)
!7 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!8 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!14 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !15, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocalVariable(name: "x", scope: !14, file: !1, line: 12, type: !19)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "X", file: !1, line: 4, size: 128, elements: !20)
!20 = !{!21, !23, !24}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "pad", scope: !19, file: !1, line: 5, baseType: !22, size: 4, flags: DIFlagBitField, extraData: i64 0)
!22 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !19, file: !1, line: 6, baseType: !4, size: 64, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !19, file: !1, line: 7, baseType: !4, size: 60, offset: 68, flags: DIFlagBitField, extraData: i64 0)
!25 = !DIExpression()
!26 = !DILocation(line: 12, column: 12, scope: !14)
!27 = !DILocalVariable(name: "bad_bits", scope: !14, file: !1, line: 13, type: !4)
!28 = !DILocation(line: 13, column: 12, scope: !14)
!29 = !DILocation(line: 15, column: 5, scope: !14)
!30 = !DILocation(line: 15, column: 9, scope: !14)
!31 = !DILocation(line: 16, column: 5, scope: !14)
!32 = !DILocation(line: 16, column: 7, scope: !14)
!33 = !DILocation(line: 17, column: 5, scope: !14)
!34 = !DILocation(line: 17, column: 7, scope: !14)
!35 = !DILocation(line: 19, column: 38, scope: !14)
!36 = !DILocation(line: 19, column: 37, scope: !14)
!37 = !DILocation(line: 19, column: 34, scope: !14)
!38 = !DILocation(line: 19, column: 32, scope: !14)
!39 = !DILocation(line: 19, column: 12, scope: !14)
!40 = !DILocation(line: 21, column: 10, scope: !14)
!41 = !DILocation(line: 21, column: 19, scope: !14)
!42 = !DILocation(line: 21, column: 3, scope: !14)
!43 = !DILocation(line: 22, column: 10, scope: !14)
!44 = !DILocation(line: 22, column: 19, scope: !14)
!45 = !DILocation(line: 22, column: 3, scope: !14)
