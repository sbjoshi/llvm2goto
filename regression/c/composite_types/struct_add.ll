; ModuleID = 'struct_add.c'
source_filename = "struct_add.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.no = type { i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.no, align 4
  %add = alloca i32, align 4
  %sub = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.no* %s, metadata !11, metadata !16), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %add, metadata !18, metadata !16), !dbg !19
  %a = getelementptr inbounds %struct.no, %struct.no* %s, i32 0, i32 0, !dbg !20
  %0 = load i32, i32* %a, align 4, !dbg !20
  %b = getelementptr inbounds %struct.no, %struct.no* %s, i32 0, i32 1, !dbg !21
  %1 = load i32, i32* %b, align 4, !dbg !21
  %add1 = add nsw i32 %0, %1, !dbg !22
  store i32 %add1, i32* %add, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %sub, metadata !23, metadata !16), !dbg !24
  %a2 = getelementptr inbounds %struct.no, %struct.no* %s, i32 0, i32 0, !dbg !25
  %2 = load i32, i32* %a2, align 4, !dbg !25
  %b3 = getelementptr inbounds %struct.no, %struct.no* %s, i32 0, i32 1, !dbg !26
  %3 = load i32, i32* %b3, align 4, !dbg !26
  %sub4 = sub nsw i32 %2, %3, !dbg !27
  store i32 %sub4, i32* %sub, align 4, !dbg !24
  ret i32 0, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "struct_add.c", directory: "/home/ubuntu/llvm2goto/regression/c/composite_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 7, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "no", file: !1, line: 1, size: 64, elements: !13)
!13 = !{!14, !15}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 2, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 3, baseType: !10, size: 32, offset: 32)
!16 = !DIExpression()
!17 = !DILocation(line: 7, column: 12, scope: !7)
!18 = !DILocalVariable(name: "add", scope: !7, file: !1, line: 8, type: !10)
!19 = !DILocation(line: 8, column: 6, scope: !7)
!20 = !DILocation(line: 8, column: 14, scope: !7)
!21 = !DILocation(line: 8, column: 20, scope: !7)
!22 = !DILocation(line: 8, column: 16, scope: !7)
!23 = !DILocalVariable(name: "sub", scope: !7, file: !1, line: 9, type: !10)
!24 = !DILocation(line: 9, column: 6, scope: !7)
!25 = !DILocation(line: 9, column: 14, scope: !7)
!26 = !DILocation(line: 9, column: 20, scope: !7)
!27 = !DILocation(line: 9, column: 16, scope: !7)
!28 = !DILocation(line: 10, column: 2, scope: !7)
