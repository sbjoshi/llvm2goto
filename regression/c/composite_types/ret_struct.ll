; ModuleID = 'ret_struct.c'
source_filename = "ret_struct.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.m = type { i32 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.m, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.m* %s, metadata !11, metadata !15), !dbg !16
  %i = getelementptr inbounds %struct.m, %struct.m* %s, i32 0, i32 0, !dbg !17
  %0 = load i32, i32* %i, align 4, !dbg !17
  ret i32 %0, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "ret_struct.c", directory: "/home/ubuntu/llvm2goto/regression/c/composite_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 5, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "m", file: !1, line: 1, size: 32, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !12, file: !1, line: 2, baseType: !10, size: 32)
!15 = !DIExpression()
!16 = !DILocation(line: 5, column: 11, scope: !7)
!17 = !DILocation(line: 6, column: 11, scope: !7)
!18 = !DILocation(line: 6, column: 2, scope: !7)
